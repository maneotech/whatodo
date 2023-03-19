import 'dart:convert';

class UserModel {
  String firstname;
  String email;
  String password;

  UserModel(this.firstname, this.email, this.password);

  factory UserModel.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return UserModel(
      json['firstname'],
      json['email'],
      json['password'],
    );
  }

  Map toJson() => {
        'firstname': firstname,
        'email': email,
        'password': password
      };

}
