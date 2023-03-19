import 'dart:convert';

import 'package:whatodo/models/response/response_user_token.dart';

class ResponseUser {
  ResponseUserToken data;

  ResponseUser(this.data);

  factory ResponseUser.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    ResponseUserToken data = ResponseUserToken.fromReqBody(jsonEncode(json['data']));
    return ResponseUser(
      data,
    );
  }
}
