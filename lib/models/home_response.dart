import 'dart:convert';

import 'package:whatodo/models/user.dart';

class HomeResponse {
  final String? lastSponsorshipEmail;
  final bool enableAdVideo;
  final UserModel user;

  HomeResponse(this.lastSponsorshipEmail, this.enableAdVideo, this.user);

  factory HomeResponse.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return HomeResponse(
      json['lastSponsorshipEmail'],
      json['enableAdVideo'],
      UserModel.fromReqBody(
        jsonEncode(json['user']),
      ),
    );
  }
}
