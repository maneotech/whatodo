import 'dart:convert';

class HomeResponse {
  final String? lastSponsorshipEmail;
  final bool enableAdVideo;
  final int token;

  HomeResponse(this.lastSponsorshipEmail, this.enableAdVideo, this.token);

  factory HomeResponse.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return HomeResponse(
      json['lastSponsorshipEmail'],
      json['enableAdVideo'],
      json['token']
    );
  }
}
