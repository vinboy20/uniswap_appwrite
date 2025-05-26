import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MonnifyService {
  final String _baseUrl = dotenv.env['MONNIFY_BASE_URL'] ?? 'https://sandbox.monnify.com/api/v1';
  final String _baseUrlV2 = 'https://sandbox.monnify.com/api/v2';
  final String _apiKey = dotenv.env['MONNIFY_API_KEY'] ?? '';
  final String _secretKey = dotenv.env['MONNIFY_SECRET_KEY'] ?? '';
  // final String _contractCode = dotenv.env['MONNIFY_CONTRACT_CODE'] ?? '';

  String? _accessToken;
  DateTime? _tokenExpiry;

  String _formatDateForMonnify(String dateStr) {
    // Converts from "DD/MM/YYYY" to "YYYY-MM-DD"
    final parts = dateStr.split('/');
    if (parts.length != 3) return dateStr;
    return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
  }

  Future<String?> _getAccessToken() async {
    // Return existing token if it's still valid (assuming 1 hour expiry)
    if (_accessToken != null && _tokenExpiry != null && _tokenExpiry!.isAfter(DateTime.now())) {
      return _accessToken;
    }

    final credentials = base64Encode(utf8.encode('$_apiKey:$_secretKey'));
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {
          'Authorization': 'Basic $credentials',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _accessToken = data['responseBody']['accessToken'];
        _tokenExpiry = DateTime.now().add(const Duration(minutes: 55)); // 5 min buffer
        return _accessToken;
      } else {
        throw Exception('Failed to get token: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Token request failed: $e');
    }
  }

  Future<Map<String, dynamic>> getWalletBalance({
    required dynamic accountNumber,
  }) async {
    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('Authentication failed');

      final response = await http.get(
        Uri.parse('$_baseUrl/disbursements/wallet/balance?accountNumber=$accountNumber'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['responseBody'];
      } else {
        throw Exception('Failed to get balance: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Balance request failed: $e');
    }
  }

  Future<Map<String, dynamic>> getWalletDetails({
    required String walletReference,
  }) async {
    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('Authentication failed');

      final response = await http.get(
        Uri.parse('$_baseUrl/disbursements/wallet/$walletReference'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['responseBody'];
      } else {
        throw Exception('Failed to get wallet details: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Wallet details request failed: $e');
    }
  }

  // Future<List<dynamic>> getWalletTransactions({
  //   required String walletReference,
  //   int page = 0,
  //   int size = 10,
  // }) async {
  //   try {
  //     final token = await _getAccessToken();
  //     if (token == null) throw Exception('Authentication failed');

  //     final response = await http.get(
  //       Uri.parse('$_baseUrl/disbursements/wallet/$walletReference/transactions?page=$page&size=$size'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Accept': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       return json.decode(response.body)['responseBody']['content'];
  //     } else {
  //       throw Exception('Failed to get transactions: ${response.statusCode} - ${response.body}');
  //     }
  //   } catch (e) {
  //     throw Exception('Transactions request failed: $e');
  //   }
  // }

  Future<Map<String, dynamic>> createWallet({
    required String customerName,
    required String customerEmail,
    required String bvn,
    required String dateOfBirth,
    String? walletReference,
  }) async {
    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('Authentication failed');

      final payload = {
        'walletReference': walletReference ?? 'wallet_${DateTime.now().millisecondsSinceEpoch}',
        'walletName': 'Wallet for $customerName',
        'customerName': customerName,
        'customerEmail': customerEmail,
        'bvnDetails': {
          'bvn': bvn,
          'bvnDateOfBirth': _formatDateForMonnify(dateOfBirth),
        },
      };

      final response = await http.post(
        Uri.parse('$_baseUrl/disbursements/wallet'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body)['responseBody'];
      } else {
        throw Exception('Failed to create wallet: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Wallet creation failed: $e');
    }
  }

  
  Future<Map<String, dynamic>> initiateSingleTransfer({
    required String amount,
    required String reference,
    String? narration,
    required String destinationBankCode,
    required String destinationAccountNumber,
    required String sourceAccountNumber,
  }) async {
    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('Authentication failed');

      final payload = {
        'amount': amount,
        'reference': reference,
        'narration': narration ?? 'Payment for goods/services',
        'destinationBankCode': destinationBankCode,
        'destinationAccountNumber': destinationAccountNumber,
        'currency': "NGN",
        'sourceAccountNumber': sourceAccountNumber,
       
      };

      print("Initiating transfer with payload: $payload"); // Debug log

      final response = await http.post(
        Uri.parse('$_baseUrlV2/disbursements/single'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      print("Transfer response: ${response.statusCode} - ${response.body}"); // Debug log

      if (response.statusCode == 200) {
        return json.decode(response.body)['responseBody'];
      } else {
        throw Exception('Transfer failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Transfer request failed: $e');
    }
  }

  /// Fetches wallet transactions with optional date filters.
  /// [accountNumber] is the account number to fetch transactions for.
  Future<List<Map<String, dynamic>>> getWalletTransactions({
    required String accountNumber,
    int page = 0,
    int size = 20,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('Authentication failed');

      // Build query parameters
      final params = {
        'accountNumber': accountNumber,
        'page': page.toString(),
        'size': size.toString(),
        if (fromDate != null) 'fromDate': fromDate.toIso8601String(),
        if (toDate != null) 'toDate': toDate.toIso8601String(),
      };

      final response = await http.get(
        Uri.parse('$_baseUrl/disbursements/wallet/transactions').replace(queryParameters: params),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('Transaction API Response: ${response.statusCode} - ${response.body}'); // Debug

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['responseBody']['content']);
      } else {
        throw Exception('Failed to fetch transactions: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Transaction fetch failed: $e');
    }
  }


  Future<Map<String, dynamic>> initiateWithdrawal({
    required String amount,
    required String reference,
    String? narration,
    required String destinationBankCode,
    required String destinationAccountNumber,
    required String sourceAccountNumber,
  }) async {
    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('Authentication failed');

      final payload = {
        'amount': amount,
        'reference': reference,
        'narration': narration ?? 'Withdrawal from wallet',
        'destinationBankCode': destinationBankCode,
        'destinationAccountNumber': destinationAccountNumber,
        'currency': "NGN",
        'sourceAccountNumber': sourceAccountNumber,
      };

      print("Initiating transfer with payload: $payload"); // Debug log

      final response = await http.post(
        Uri.parse('$_baseUrlV2/disbursements/single'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      print("Transfer response: ${response.statusCode} - ${response.body}"); // Debug log

      if (response.statusCode == 200) {
        return json.decode(response.body)['responseBody'];
      } else {
        throw Exception('Transfer failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Transfer request failed: $e');
    }
  }






}
