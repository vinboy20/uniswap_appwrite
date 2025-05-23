import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniswap/features/home/screens/home_container/home_container.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final double amount;

  const PaymentSuccessDialog({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Payment Successful'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 48),
          const SizedBox(height: 16),
          Text(
            '₦${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('Your payment was successful!'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.offAll(() => HomeContainer());
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
