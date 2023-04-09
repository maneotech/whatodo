import 'dart:convert';

class UserModel {
  String firstname;
  int token;

  UserModel(this.firstname, this.token);

  factory UserModel.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return UserModel(
      json['firstname'],
      json['token'],
    );
  }
}

enum UserThirdPart {
  facebook,
  google,
  apple
}
