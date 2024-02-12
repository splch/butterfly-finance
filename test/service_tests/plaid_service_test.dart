import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:butterfly_finance/services/plaid_service.dart';

import 'plaid_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late PlaidService plaidService;

  setUp(() {
    mockClient = MockClient();
    plaidService =
        PlaidService(clientId: 'your_client_id', secret: 'your_secret');
    plaidService.client = mockClient;
  });

  group('PlaidService', () {
    test('createLinkToken returns a LinkTokenResponse on successful response',
        () async {
      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(
              '{"link_token": "test_link_token", "expiration": "2020-03-27T12:56:34Z", "request_id": "test_request_id"}',
              200));

      final result =
          await plaidService.createLinkToken(clientUserId: 'user_id');
      expect(result.linkToken, 'test_link_token');
      expect(result.requestId, 'test_request_id');
    });

    test('createLinkToken throws an exception on failure', () {
      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(plaidService.createLinkToken(clientUserId: 'user_id'),
          throwsException);
    });
  });
}
