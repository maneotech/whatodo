import 'package:flutter/material.dart';

class Constants {
    static const String sharedPrefKeyLanguage = "language";
    static const String sharedPrefKeyJwt = "jwt";

  static const TextStyle defaultTextStyle = TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.black);


  static const TextStyle signupTitle = TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black);

  static const TextStyle activityTitleTextStyle = TextStyle(
      fontSize: 12.0, color: Colors.white, fontFamily: "Hellix");

  static const EdgeInsets paddingButtons = EdgeInsets.all(10.0);
  static const EdgeInsets paddingLogin = EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0);
  static const EdgeInsets paddingTop = EdgeInsets.only(top: 40.0);

  static const Color primaryColor = Color.fromRGBO(255,105,61, 1.0);
  static const String loginImage = "assets/images/login.jpg";


}