import 'dart:convert';

class UserRequestModel {
  String firstname;
  String email;
  String password;

  UserRequestModel(this.firstname, this.email, this.password);

  factory UserRequestModel.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return UserRequestModel(
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
