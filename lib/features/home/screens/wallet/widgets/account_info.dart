import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';
import 'package:uniswap/data/saved_data.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
 
  final user = SavedData.getUserData();
 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            'Bank Account Info',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Transfer funds to your dedicated bank account, and your wallet will be funded within the hour. Charges may apply',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          _infoRow(label: 'Bank Name', value: user['bankName'] ?? ''),
          _infoRow(label: 'Account Name', value: user['accountName'] ?? ''),
          _infoRow(label: 'Account Number', value: user['topUpAccountNumber'] ?? ''),
          _infoRow(label: 'Currency', value: 'NGN'),
        ],
      ),
    );
  }

  Widget _infoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
          Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
