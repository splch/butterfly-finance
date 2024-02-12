import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:butterfly_finance/models/link_token_response.dart';

class PlaidService {
  final String clientId;
  final String secret;
  final String baseUrl = 'https://production.plaid.com';
  final String redirectUri =
      'https://splch.github.io/butterfly-finance-redirect/';
  http.Client client = http.Client();

  PlaidService({required this.clientId, required this.secret});

  Future<LinkTokenResponse> createLinkToken({
    required String clientUserId,
    int transactionsDaysRequested = 730,
  }) async {
    final Uri url = Uri.parse('$baseUrl/link/token/create');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'client_id': clientId,
        'secret': secret,
        'user': {
          'client_user_id': clientUserId,
        },
        'client_name': 'Butterfly Finance',
        'products': ['auth', 'balance', 'transactions'],
        'transactions': {
          'days_requested': transactionsDaysRequested,
        },
        'country_codes': ['US'],
        'language': 'en',
        'redirect_uri': redirectUri,
      }),
    );

    if (response.statusCode == 200) {
      return LinkTokenResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create link token: ${response.body}');
    }
  }
}
