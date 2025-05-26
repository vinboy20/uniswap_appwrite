import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:uniswap/controllers/database_controller.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/data/saved_data.dart';
import 'package:uniswap/service/monify_service.dart';

class MonnifyController extends GetxController {
  final MonnifyService _monnifyService = MonnifyService();

  // final String _apiKey = dotenv.env['MONNIFY_API_KEY']!;
  // final String _contractCode = dotenv.env['MONNIFY_CONTRACT_CODE']!;
  final String txRef = "uniswap_${Random().nextInt(100000)}";

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

  final isLoading = false.obs;
  final accountBalance = <String, dynamic>{}.obs;
  final isAmountVisible = true.obs;
  final errorMessage = ''.obs;
  final paymentStatus = ''.obs;

  // Observable list for transactions
  final transactions = <Map<String, dynamic>>[].obs;
  final isLoadingTransactions = false.obs;
  final transactionError = ''.obs;
  final currentPage = 0.obs;
  final totalPages = 1.obs;

  @override
  void onInit() {
    print("Initializing MonnifyController..."); // Debug print
    fetchWalletBalance();

    super.onInit();
  }

  // Format date as "Month Day, Time" (e.g., "July 19, 8:00PM")
  String formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString).toLocal();
      return DateFormat('MMMM d, h:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }

// Format amount with currency symbol
  String formatAmount(num amount) {
    return NumberFormat.currency(
      symbol: '₦',
      decimalDigits: 2,
    ).format(amount).replaceAll('.00', '');
  }

  // GetUser ID
  Future<String?> getCurrentUserId() async {
    try {
      final user = await _account.get();
      return user.$id;
    } catch (e) {
      Get.log('Error getting current user: $e', isError: true);
      return null;
    }
  }

  // Fetch wallet balance
  /// Fetches the wallet balance for the current user.
  Future<void> fetchWalletBalance() async {
    try {
      print("Fetching wallet balance..."); // Debug print
      isLoading.value = true;
      errorMessage.value = '';

      final userData = SavedData.getUserData();

      if (userData.isEmpty) {
        errorMessage.value = 'User data is empty';
        print(errorMessage.value); // Debug print
        return;
      }

      if (userData['accountNumber'] == null) {
        errorMessage.value = 'Wallet is not available';
        print(errorMessage.value); // Debug print
        return;
      }
      String accountNumber = userData['accountNumber'];
      final result = await _monnifyService.getWalletBalance(
        accountNumber: accountNumber,
      );

      print("API Response: $result"); // Debug print

      if (result != null) {
        accountBalance.value = result;
        print("Balance updated: $result"); // Debug print
      } else {
        errorMessage.value = 'Failed to load balance';
        print(errorMessage.value); // Debug print
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      print(errorMessage.value); // Debug print
    } finally {
      isLoading.value = false;
      print("Loading completed"); // Debug print
    }
  }

  String formatCurrency(num? amount) {
    return NumberFormat.currency(
      locale: 'en_NG',
      symbol: '₦',
      decimalDigits: 2,
    ).format(amount ?? 0);
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

  Future<Map<String, dynamic>> processPayment({
    required String amount,
    // required String sellerAccountNumber,
    // required String sellerBankCode,
    // required String sellerName,
    required String userId,
    required String sellerId,
    required String productId,
    required String deliveryDate,
    required String deliveryTime,
    required String exchange,
    required String location,
  }) async {
    try {
      isLoading.value = true;
      paymentStatus.value = 'processing';
      errorMessage.value = '';

      // Generate a unique reference for the transaction
      final reference = 'PAY_${DateTime.now().millisecondsSinceEpoch}';

      final seller = await DatabaseController.instance.getUserRecord(sellerId);
      final buyer = await DatabaseController.instance.getUserRecord(userId);

      if (seller == null || buyer == null) {
        errorMessage.value = 'Seller or buyer not found';
        return {
          'success': false,
          'message': errorMessage.value,
        };
      }

      // Initiate transfer to merchant/Escrow wallet account
      final transferResult = await _monnifyService.initiateSingleTransfer(
        amount: amount,
        reference: reference,
        destinationBankCode: '001',
        destinationAccountNumber: '3921279677', //escrow account number
        sourceAccountNumber: buyer.accountNumber ?? 'Unknown Seller',
        narration: 'Send to escrow account for product purchase',
      );

      // If transfer was successful
      if (transferResult['status'] == 'PENDING_AUTHORIZATION') {
        paymentStatus.value = 'completed';
        // 4. Create transaction record first (acts as a lock)
        print('7. Creating transaction record...');

        // 4. Create transaction record first (acts as a lock)
        String generateVerificationCode() {
          final random = Random();
          return (100000 + random.nextInt(900000)).toString();
        }

        final String txRef = "uniswap_${Random().nextInt(100000)}";

        final verificationCode = generateVerificationCode();
        // 6. Create notifications

        // For Buyer
        print('11. Creating notifications...');
        await Future.wait([
          _databases.createDocument(
            databaseId: databaseId,
            collectionId: notificationCollectionId,
            documentId: ID.unique(),
            data: {
              'userId': userId,
              'type': 'payment_verification',
              'title': 'Verification Code',
              'amount': amount.toString(),
              'verificationCode': verificationCode,
              'transactionId': txRef,
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
              'transactionId': txRef,
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
        return {
          'success': true,
          'message': 'Payment successful',
          'reference': reference,
          'transaction': transferResult,
        };
      } else {
        paymentStatus.value = 'failed';
        errorMessage.value = transferResult['message'] ?? 'Payment failed';
        return {
          'success': false,
          'message': transferResult['message'] ?? 'Payment failed',
        };
      }
    } catch (e) {
      paymentStatus.value = 'failed';
      errorMessage.value = e.toString();
      return {
        'success': false,
        'message': e.toString(),
      };
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> fetchWalletTransactions({
  //   required String accountNumber,
  //   bool loadMore = false,
  //   DateTime? fromDate,
  //   DateTime? toDate,
  // }) async {
  //   try {
  //     isLoadingTransactions.value = true;
  //     transactionError.value = '';

  //     if (!loadMore) {
  //       currentPage.value = 0;
  //       transactions.clear();
  //     }

  //     final result = await _monnifyService.getWalletTransactions(
  //       accountNumber: accountNumber,
  //       page: currentPage.value,
  //       size: 20,
  //       fromDate: fromDate,
  //       toDate: toDate,
  //     );

  //     transactions.addAll(result);

  //     // Update pagination (if API provides total pages)
  //     // totalPages.value = data['responseBody']['totalPages'] ?? 1;
  //   } catch (e) {
  //     transactionError.value = e.toString();
  //     print('Transaction fetch error: $e');
  //   } finally {
  //     isLoadingTransactions.value = false;
  //   }
  // }

  Future<void> fetchTransactions(String accountNumber) async {
    try {
      isLoadingTransactions.value = true;
      final response = await _monnifyService.getWalletTransactions(accountNumber: accountNumber);

      // Sort by date (newest first)
      response.sort((a, b) => DateTime.parse(b['transactionDate']).compareTo(DateTime.parse(a['transactionDate'])));

      transactions.assignAll(response);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load transactions');
    } finally {
      isLoadingTransactions.value = false;
    }
  }

  // Get status color
  Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'SUCCESS':
        return Colors.green;
      case 'FAILED':
        return Colors.red;
      case 'PENDING':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }


Future<Map<String, dynamic>> processWithdrawal({
    required String amount,
    required String userId,
   
  }) async {
    try {
      isLoading.value = true;
      paymentStatus.value = 'processing';
      errorMessage.value = '';

      // Generate a unique reference for the transaction
      final reference = 'PAY_${DateTime.now().millisecondsSinceEpoch}';
      final user = await DatabaseController.instance.getUserRecord(userId);
      if (user == null) {
        errorMessage.value = 'User not found';
        return {
          'success': false,
          'message': errorMessage.value,
        };
      }
     

      // Initiate transfer to merchant/Escrow wallet account
      final transferResult = await _monnifyService.initiateSingleTransfer(
        amount: amount,
        reference: reference,
        destinationBankCode: user.bankCode ?? 'Unknown user',
        destinationAccountNumber: user.accountNumber ?? 'Unknown user', //escrow account number
        sourceAccountNumber: user.accountNumber ?? 'Unknown user',
        narration: 'Withdraw from wallet',
      );

      // If transfer was successful
      if (transferResult['status'] == 'PENDING_AUTHORIZATION') {
        paymentStatus.value = 'completed';
        // 4. Create transaction record first (acts as a lock)
        print('7. Creating transaction record...');

        // 4. Create transaction record first (acts as a lock)
        String generateVerificationCode() {
          final random = Random();
          return (100000 + random.nextInt(900000)).toString();
        }

        final String txRef = "withdraw_${Random().nextInt(100000)}";

        // final verificationCode = generateVerificationCode();
        // 6. Create notifications

        print('11. Creating notifications...');
        await Future.wait([
          _databases.createDocument(
            databaseId: databaseId,
            collectionId: notificationCollectionId,
            documentId: ID.unique(),
            data: {
              'userId': userId,
              'type': 'Withdraw',
              'title': 'Withdraw from wallet',
              'amount': amount.toString(),
              'transactionId': txRef,
              'isRead': false,
             
            },
          ).catchError((e) {
            // print('Error creating buyer notification: ${e.toString()}');
            throw Exception('notification creation failed: $e');
          }),

          
        ]);
        // print('12. Notifications created successfully');
        return {
          'success': true,
          'message': 'Payment successful',
          'reference': reference,
          'transaction': transferResult,
        };
      } else {
        paymentStatus.value = 'failed';
        errorMessage.value = transferResult['message'] ?? 'Payment failed';
        return {
          'success': false,
          'message': transferResult['message'] ?? 'Payment failed',
        };
      }
    } catch (e) {
      paymentStatus.value = 'failed';
      errorMessage.value = e.toString();
      return {
        'success': false,
        'message': e.toString(),
      };
    } finally {
      isLoading.value = false;
    }
  }



}
