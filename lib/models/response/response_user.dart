import 'dart:convert';

import 'package:whatodo/models/response/response_user_token.dart';

import '../user.dart';

class ResponseUser {
  ResponseUserToken data;
  UserModel user;

  ResponseUser(this.data, this.user);

  factory ResponseUser.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    ResponseUserToken responseUserToken =
        ResponseUserToken.fromReqBody(jsonEncode(json['data']));
    UserModel userModel =
        UserModel.fromReqBody(jsonEncode(json['user']));

    return ResponseUser(
      responseUserToken,
      userModel
    );
  }
}
