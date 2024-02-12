import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/link_token_response.dart';

void main() {
  group('LinkTokenResponse', () {
    test('fromJson correctly parses JSON', () {
      final json = {
        'link_token': 'link-sandbox-af1a0311-da53-4636-b754-dd15cc058176',
        'expiration': '2020-03-27T12:56:34Z',
        'request_id': 'XQVgFigpGHXkb0b',
      };

      final result = LinkTokenResponse.fromJson(json);

      expect(result, isA<LinkTokenResponse>());
      expect(result.linkToken,
          'link-sandbox-af1a0311-da53-4636-b754-dd15cc058176');
      expect(result.expiration, DateTime.parse('2020-03-27T12:56:34Z'));
      expect(result.requestId, 'XQVgFigpGHXkb0b');
    });
  });
}
