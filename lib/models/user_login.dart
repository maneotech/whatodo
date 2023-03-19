import 'dart:convert';

class UserLoginModel {
  String email;
  String password;

  UserLoginModel(this.email, this.password);

  factory UserLoginModel.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return UserLoginModel(
      json['email'],
      json['password'],
    );
  }

  Map toJson() => {'email': email, 'password': password};
}
