import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MonnifyService {
  final String _baseUrl = dotenv.env['MONNIFY_BASE_URL'] ?? 'https://sandbox.monnify.com/api/v1';
  final String _apiKey = dotenv.env['MONNIFY_API_KEY'] ?? '';
  final String _secretKey = dotenv.env['MONNIFY_SECRET_KEY'] ?? '';
  // final String _contractCode = dotenv.env['MONNIFY_CONTRACT_CODE'] ?? '';

  String? _accessToken;
  DateTime? _tokenExpiry;

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

  Future<List<dynamic>> getWalletTransactions({
    required String walletReference,
    int page = 0,
    int size = 10,
  }) async {
    try {
      final token = await _getAccessToken();
      if (token == null) throw Exception('Authentication failed');

      final response = await http.get(
        Uri.parse('$_baseUrl/disbursements/wallet/$walletReference/transactions?page=$page&size=$size'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body)['responseBody']['content'];
      } else {
        throw Exception('Failed to get transactions: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Transactions request failed: $e');
    }
  }

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

  String _formatDateForMonnify(String dateStr) {
    // Converts from "DD/MM/YYYY" to "YYYY-MM-DD"
    final parts = dateStr.split('/');
    if (parts.length != 3) return dateStr;
    return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
  }
}
