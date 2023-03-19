import 'dart:convert';

class ResponseUserToken {
  String token;
  String tokenExpireAt;
  String refreshToken;
  String refreshTokenExpireAt;

  ResponseUserToken(this.token, this.tokenExpireAt, this.refreshToken, this.refreshTokenExpireAt);

  factory ResponseUserToken.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return ResponseUserToken(
      json['token'],
      json['tokenExpireAt'],
      json['refreshToken'],
      json['refreshTokenExpireAt'],
    );
  }
}
