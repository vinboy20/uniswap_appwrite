import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniswap/service/monify_service.dart';

class MonnifyController extends GetxController {
  final MonnifyService _monnifyService = MonnifyService();

  final String _apiKey = dotenv.env['MONNIFY_API_KEY']!;
  final String _contractCode = dotenv.env['MONNIFY_CONTRACT_CODE']!;
  final String txRef = "uniswap_${Random().nextInt(100000)}";

final isLoading = false.obs;
  final accountBalance = <String, dynamic>{}.obs;
  final isAmountVisible = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    print("Initializing MonnifyController..."); // Debug print
    fetchWalletBalance();
    super.onInit();
  }

  Future<void> fetchWalletBalance() async {
    try {
      print("Fetching wallet balance..."); // Debug print
      isLoading.value = true;
      errorMessage.value = '';

      // Use the correct parameter name (walletReference instead of accountNumber)
      final result = await _monnifyService.getWalletBalance(
        accountNumber: '8147445824', // Replace with your actual wallet reference
      );

      print("API Response: $result"); // Debug print

      if (result != null) {
        accountBalance.value = result;
        print("Balance updated: $result"); // Debug print
      } else {
        errorMessage.value = 'Failed to load balance: Empty response';
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

  void toggleAmountVisibility() {
    isAmountVisible.toggle();
    print("Amount visibility toggled: ${isAmountVisible.value}"); // Debug print
  }
}

