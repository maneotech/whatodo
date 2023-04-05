import 'dart:convert';

class HomeResponse {
  final String? lastSponsorshipEmail;
  final bool enableAdVideo;

  HomeResponse(this.lastSponsorshipEmail, this.enableAdVideo);

  factory HomeResponse.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return HomeResponse(
      json['lastSponsorshipEmail'],
      json['enableAdVideo'],
    );
  }
}
