import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:whatodo/models/user_login.dart';

import '../models/user.dart';

class BaseAPI {
  static String base = "http://localhost:3010";
  static String api = "$base/api";
  static Uri signupPath = Uri.parse("$api/user/register");
  static Uri loginPath = Uri.parse("$api/user/login");
  static String googleApiKey = "AIzaSyBv2zOoqxBElmBJH4jFBieXnoDXqy_YRkw";
  // more routes
  static Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  static Future<Response> signUpWithEmail(UserModel user) async {
    return await http.Client()
        .post(signupPath, headers: headers, body: jsonEncode(user));
  }

  static Future<Response> signInWithEmail(UserLoginModel userLogin) async {
    return await http.Client()
        .post(loginPath, headers: headers, body: jsonEncode(userLogin));
  }

  /**
   * GOOGLE API BELOW
   */

  static Future<Response> findPlaces() async {

    String input="restaurant";
    String inputtype = "textquery";
    String fields = "formatted_address,name,geometry";
    String location = "43.529743,5.447427";
    String radius = "16000";
    String url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=$inputtype&fields=$fields&location=$location&radius=$radius&key=$googleApiKey";



    String proxyServerUrl = 'https://cors-anywhere.herokuapp.com/';
    String encodedUrl = Uri.encodeFull(url);
    String fullUrl = '$proxyServerUrl$encodedUrl';
    Uri findPlacesPath = Uri.parse(fullUrl);
    return await http.Client().get(findPlacesPath);
  }
}