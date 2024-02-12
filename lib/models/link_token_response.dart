class LinkTokenResponse {
  final String linkToken;
  final DateTime expiration;
  final String requestId;

  LinkTokenResponse({
    required this.linkToken,
    required this.expiration,
    required this.requestId,
  });

  factory LinkTokenResponse.fromJson(Map<String, dynamic> json) {
    return LinkTokenResponse(
      linkToken: json['link_token'],
      expiration: DateTime.parse(json['expiration']),
      requestId: json['request_id'],
    );
  }
}
