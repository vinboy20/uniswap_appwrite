import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';
import 'package:uniswap/features/home/screens/wallet/virtual_wallet_screen.dart';

class PaymentController extends GetxController {
  static PaymentController get instance => Get.find();

  final Account _account = Account(Get.find<Client>()); // Use Get.find<Client>()
  final Databases _databases = Databases(Get.find<Client>());

  final String databaseId = Credentials.databaseId; // Replace with your Database ID
  final String userCollectionId = Credentials.usersCollectonId; // Replace with your Collection ID
  final String identityCollectionId = Credentials.identificationCollectionId; // Replace with your Collection ID
  final String walletCollectionId = Credentials.walletCollectionId; // Replace with your Collection ID
  final String transactionCollectionId = Credentials.transactionCollectionId; // Replace with your Collection ID
  final String chatCollectionId = Credentials.chatCollectionId;
  final String notificationCollectionId = Credentials.notificationCollectionId;
  final String productCollectionId = Credentials.productCollectionId;

  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<String?> getCurrentUserId() async {
    try {
      final user = await _account.get();
      return user.$id;
    } catch (e) {
      Get.log('Error getting current user: $e', isError: true);
      return null;
    }
  }

  // Verify pin
  Future<bool> verifyPin(String userId, String enteredPin) async {
    try {
      EasyLoading.show(status: 'Verifying...');
      final user = await _databases.getDocument(
        databaseId: databaseId,
        collectionId: userCollectionId,
        documentId: userId,
      );

      final storedPin = user.data['pincode'] as String?;
      final useBiometric = user.data['biometric'] as bool? ?? false;

      if (useBiometric) {
        try {
          EasyLoading.show(status: 'Waiting for biometric...');
          final result = await _localAuth.authenticate(
            localizedReason: 'Authenticate to complete payment',
            options: const AuthenticationOptions(
              biometricOnly: true,
            ),
          );
          EasyLoading.dismiss();
          return result;
        } catch (e) {
          EasyLoading.dismiss();
          Get.log('Biometric auth failed: $e', isError: true);
          return false;
        }
      }

      EasyLoading.dismiss();
      return storedPin == enteredPin;
    } catch (e) {
      EasyLoading.dismiss();
      Get.log('PIN verification failed: $e', isError: true);
      return false;
    }
  }

  // Proccess Payment
  Future<Map<String, dynamic>> processPayment({
    required String buyerId,
    required String sellerId,
    required double amount,
    required String productId,
    required deliveryDate,
    required deliveryTime,
    required exchange,
    required location,
  }) async {
    double originalBuyerBalance = 0;
    double originalSellerEscrow = 0;
    String? transactionDocId;

    try {
      EasyLoading.show(status: 'Processing payment...');
      print('1. Starting payment process for buyer: $buyerId, amount: $amount');

      // 1. Get current balances (with rollback data)
      print('2. Getting buyer wallet...');
      final buyerWallet = await _databases
          .getDocument(
        databaseId: databaseId,
        collectionId: walletCollectionId,
        documentId: buyerId,
      )
          .catchError((e) {
        print('Error getting buyer wallet: ${e.toString()}');
        throw Exception('Buyer wallet not found: $e');
      });

      print('3. Getting seller wallet...');
      final sellerWallet = await _databases
          .getDocument(
        databaseId: databaseId,
        collectionId: walletCollectionId,
        documentId: sellerId,
      )
          .catchError((e) {
        print('Error getting seller wallet: ${e.toString()}');
        throw Exception('Seller wallet not found: $e');
      });

      originalBuyerBalance = double.parse(buyerWallet.data['balance'] ?? '0');
      originalSellerEscrow = double.parse(sellerWallet.data['escrowBalance'] ?? '0');
      print('4. Balances - Buyer: $originalBuyerBalance, Seller Escrow: $originalSellerEscrow');

      // 2. Validate balances
      if (originalBuyerBalance < amount) {
        print('5. Insufficient funds: $originalBuyerBalance < $amount');
        EasyLoading.dismiss();
        return {'success': false, 'message': 'Insufficient funds'};
      }

      // 3. Generate verification code
      String generateVerificationCode() {
        final random = Random();
        return (100000 + random.nextInt(900000)).toString();
      }

      final String txRef = "uniswap_${Random().nextInt(100000)}";

      final verificationCode = generateVerificationCode();
      print('6. Generated verification code: $verificationCode');

      // 4. Create transaction record first (acts as a lock)
      print('7. Creating transaction record...');

      try {
        final transaction = await _databases.createDocument(
          databaseId: databaseId,
          collectionId: transactionCollectionId,
          documentId: ID.unique(),
          data: {
            'buyerId': buyerId,
            'sellerId': sellerId,
            'amount': amount.toString(),
            'productId': productId,
            'status': 'processing',
            'txRef': txRef,
            'type': 'escrow',
            'verificationCode': verificationCode,
            'deliveryDate': deliveryDate,
            'deliveryTime': deliveryTime,
            'exchange': exchange,
            'location': location,
            // 'createdAt': DateTime.now().toIso8601String(),
          },
        );

        /// ✅ Store the document ID
        transactionDocId = transaction.$id;
        print('8. Transaction created with ID: $transactionDocId');
      } catch (e) {
        print('Error creating transaction: ${e.toString()}');
        rethrow;
      }

      try {
        EasyLoading.show(status: 'Updating balances...');
        print('9. Updating balances...');

        // 5. Update balances in parallel
        // for buyer
        await Future.wait([
          _databases.updateDocument(
            databaseId: databaseId,
            collectionId: walletCollectionId,
            documentId: buyerId,
            data: {'balance': (originalBuyerBalance - amount).toString()},
          ).catchError((e) {
            print('Error updating buyer balance: ${e.toString()}');
            throw Exception('Buyer balance update failed: $e');
          }),
          // for seller
          _databases.updateDocument(
            databaseId: databaseId,
            collectionId: walletCollectionId,
            documentId: sellerId,
            data: {'escrowBalance': (originalSellerEscrow + amount).toString()},
          ).catchError((e) {
            print('Error updating seller escrow: ${e.toString()}');
            throw Exception('Seller escrow update failed: $e');
          }),
        ]);
        print('10. Balance updates completed successfully');

        // 6. Create notifications

        // For Buyer
        print('11. Creating notifications...');
        await Future.wait([
          _databases.createDocument(
            databaseId: databaseId,
            collectionId: notificationCollectionId,
            documentId: ID.unique(),
            data: {
              'userId': buyerId,
              'type': 'payment_verification',
              'title': 'Verification Code',
              'amount': amount.toString(),
              'verificationCode': verificationCode,
              'transactionId': transactionDocId,
              'isRead': false,
              'metaProductId': productId,
              'metaDeliveryDate': deliveryDate,
              'metaDeliveryTime': deliveryTime,
            },
          ).catchError((e) {
            // print('Error creating buyer notification: ${e.toString()}');
            throw Exception('Buyer notification creation failed: $e');
          }),

          // for seller
          _databases.createDocument(
            databaseId: databaseId,
            collectionId: notificationCollectionId,
            documentId: ID.unique(),
            data: {
              'userId': sellerId,
              'type': 'payment_escrowed',
              'title': 'Payment Received (Escrow)',
              'amount': amount.toString(),
              'transactionId': transactionDocId,
              'isRead': false,
              'metaProductId': productId,
              'metaDeliveryDate': deliveryDate,
              'metaDeliveryTime': deliveryTime,
            },
          ).catchError((e) {
            // print('Error creating seller notification: ${e.toString()}');
            throw Exception('Seller notification creation failed: $e');
          }),
        ]);
        // print('12. Notifications created successfully');

        // 7. Finalize transaction
        // print('13. Finalizing transaction...');
        await _databases.updateDocument(
          databaseId: databaseId,
          collectionId: transactionCollectionId,
          documentId: transactionDocId,
          data: {'status': 'pending'},
        ).catchError((e) {
          print('Error finalizing transaction: ${e.toString()}');
          throw Exception('Transaction finalization failed: $e');
        });

        // update and remove product from list
        await _databases.updateDocument(
          databaseId: databaseId,
          collectionId: productCollectionId,
          documentId: productId,
          data: {'status': false},
        ).catchError((e) {
          print('Error finalizing transaction: ${e.toString()}');
          throw Exception('Transaction finalization failed: $e');
        });

        // print('14. Payment completed successfully');
        EasyLoading.dismiss();
        return {
          'success': true,
        };
      } catch (e) {
        print('15. Error during payment processing: ${e.toString()}');
        print('Attempting rollback...');

        // Rollback balances if anything fails after transaction creation
        try {
          await _rollbackBalances(
            buyerId: buyerId,
            sellerId: sellerId,
            originalBuyerBalance: originalBuyerBalance,
            originalSellerEscrow: originalSellerEscrow,
          );
          print('16. Rollback completed successfully');
        } catch (rollbackError) {
          print('17. Rollback failed: ${rollbackError.toString()}');
          // Critical error - consider alerting admin
        }

        // Mark transaction as failed
        if (transactionDocId != null) {
          try {
            await _databases.updateDocument(
              databaseId: databaseId,
              collectionId: transactionCollectionId,
              documentId: transactionDocId,
              // data: {'status': 'failed', 'error': e.toString()},
              data: {'status': 'failed'},
            );
            print('18. Transaction marked as failed');
          } catch (updateError) {
            print('19. Failed to mark transaction as failed: ${updateError.toString()}');
          }
        }

        EasyLoading.showError('Payment failed');
        return {
          'success': false,
          'message': 'Payment failed. No funds were deducted.',
          'error': e.toString(),
        };
      }
    } on AppwriteException catch (e) {
      print('20. AppwriteException: ${e.toString()}');
      print('Type: ${e.type}');
      print('Code: ${e.code}');
      print('Message: ${e.message}');
      print('Response: ${e.response}');

      EasyLoading.showError('Payment error');
      return {
        'success': false,
        'message': 'Appwrite error: ${e.message}',
        'error': e.toString(),
        'type': e.type,
        'code': e.code,
      };
    } catch (e) {
      print('21. Unexpected error: ${e.toString()}');
      // print('Stack trace: ${e.stackTrace}');

      EasyLoading.showError('Payment error');
      return {
        'success': false,
        'message': 'Payment initialization failed',
        'error': e.toString(),
      };
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Rollback method
  Future<void> _rollbackBalances({
    required String buyerId,
    required String sellerId,
    required double originalBuyerBalance,
    required double originalSellerEscrow,
  }) async {
    print('Starting rollback process...');
    try {
      await Future.wait([
        _databases.updateDocument(
          databaseId: databaseId,
          collectionId: walletCollectionId,
          documentId: buyerId,
          data: {'balance': originalBuyerBalance.toString()},
        ),
        _databases.updateDocument(
          databaseId: databaseId,
          collectionId: walletCollectionId,
          documentId: sellerId,
          data: {'escrowBalance': originalSellerEscrow.toString()},
        ),
      ]);
      print('Rollback completed successfully');
    } catch (e) {
      print('Rollback failed: ${e.toString()}');
      rethrow;
    }
  }

  // confirmDelivery
  Future<Map<String, dynamic>> confirmDelivery({
    required String transactionId,
    required String verificationCode,
    required String sellerId,
    required String productId,
  }) async {
    try {
      EasyLoading.show(status: 'Verifying...');

      // 1. Get transaction
      final transaction = await _databases.getDocument(
        databaseId: databaseId,
        collectionId: transactionCollectionId,
        documentId: transactionId,
      );

      // Validate
      if (transaction.data['status'] != 'pending') {
        throw Exception('Transaction already processed');
      }

      // if (verificationCode != verificationCode) {
      //   throw Exception('Invalid verification code');
      // }
      if (transaction.data['verificationCode'] != verificationCode) {
        // TLoaders.warningSnackBar(title: 'warning', message: 'Invalid verification code');
        throw Exception('Invalid verification code');
      }

      if (transaction.data['sellerId'] != sellerId) {
        // TLoaders.warningSnackBar(title: 'warning', message: 'Unauthorized confirmation');
        throw Exception('Unauthorized confirmation');
      }

      final buyerId = transaction.data['buyerId'];
      final amount = double.parse(transaction.data['amount']);

      // 2. Get wallets
      final sellerWallet = await _databases.getDocument(
        databaseId: databaseId,
        collectionId: walletCollectionId,
        documentId: sellerId,
      );
      final sellerEscrow = double.parse(sellerWallet.data['escrowBalance'] ?? '0');
      final sellerBalance = double.parse(sellerWallet.data['balance'] ?? '0');

      // Verify escrow has sufficient funds
      if (sellerEscrow < amount) {
        TLoaders.warningSnackBar(title: 'warning', message: 'Insufficient escrow balance');
        // throw Exception('Insufficient escrow balance');
      }

      // 3. Transfer from escrow to main balance
      await Future.wait([
        _databases.updateDocument(
          databaseId: databaseId,
          collectionId: walletCollectionId,
          documentId: sellerId,
          data: {
            'escrowBalance': (sellerEscrow - amount).toString(),
            'balance': (sellerBalance + amount).toString(),
          },
        ),
        _databases.updateDocument(
          databaseId: databaseId,
          collectionId: transactionCollectionId,
          documentId: transactionId,
          data: {'status': 'completed'},
        ),
      ]);

      // 4. Create notifications
      await Future.wait([
        // Buyer notification
        _databases.createDocument(
          databaseId: databaseId,
          collectionId: notificationCollectionId,
          documentId: ID.unique(),
          data: {
            'userId': buyerId,
            'type': 'delivery_confirmed',
            'title': 'Delivery Confirmed',
            'metaProductId': productId,
            'amount': amount.toString(),
            'isRead': false,
          },
        ),
        // Seller notification
        _databases.createDocument(
          databaseId: databaseId,
          collectionId: notificationCollectionId,
          documentId: ID.unique(),
          data: {
            'userId': sellerId,
            'type': 'payment_released',
            'title': 'Payment Released',
            'metaProductId': productId,
            'isRead': false,
            'amount': amount.toString(),
          },
        ),
      ]);

      EasyLoading.showSuccess('Payment released!');
      Get.offAll(() => VirtualWalletScreen);
      return {'success': true};
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e.toString());
      return {'success': false, 'message': e.toString()};
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Future<Map<String, dynamic>> sellerConfirmDelivery({
  //   required String transactionId,
  //   required String verificationCode,
  //   required String buyerId,
  // }) async {
  //   try {
  //      // 1. Get transaction
  //     final transaction = await _databases.getDocument(
  //       databaseId: databaseId,
  //       collectionId: transactionCollectionId,
  //       documentId: transactionId,
  //     );

  //     // Validate
  //     if (transaction.data['status'] != 'pending') {
  //       TLoaders.warningSnackBar(title: 'warning', message: "Transaction already processed");
  //       // throw Exception('Transaction already processed');
  //     }

  //     if (transaction.data['verificationCode'] != verificationCode) {
  //       TLoaders.warningSnackBar(title: 'warning', message: 'Invalid verification code');
  //       // throw Exception('Invalid verification code');
  //     }

  //     if (transaction.data['buyerId'] != buyerId) {
  //       TLoaders.warningSnackBar(title: 'warning', message: 'Unauthorized confirmation');
  //       // throw Exception('Unauthorized confirmation');
  //     }
  //     return {'success': true};
  //   } catch (e) {
  //     return {'success': false, 'message': e.toString()};

  //   }
  // }

  Future<void> reconcileStuckTransactions() async {
    try {
      EasyLoading.show(status: 'Checking transactions...');
      final stuckTransactions = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: transactionCollectionId,
        queries: [
          Query.equal('status', 'processing'),
          Query.lessThan('date', DateTime.now().subtract(const Duration(minutes: 30)).toIso8601String()),
        ],
      );

      if (stuckTransactions.documents.isEmpty) {
        EasyLoading.dismiss();
        return;
      }

      EasyLoading.show(
        status: 'Reconciling ${stuckTransactions.documents.length} transactions...',
        maskType: EasyLoadingMaskType.black,
      );

      for (final doc in stuckTransactions.documents) {
        try {
          // ... (keep your existing reconciliation logic)
        } catch (e) {
          Get.log('Error reconciling transaction ${doc.$id}: $e', isError: true);
        }
      }

      EasyLoading.showSuccess('Reconciliation complete!');
    } catch (e) {
      EasyLoading.showError('Reconciliation failed');
      Get.log('Error fetching stuck transactions: $e', isError: true);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
