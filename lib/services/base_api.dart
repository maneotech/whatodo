import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:whatodo/models/request_place.dart';
import 'package:whatodo/models/user_login.dart';

import '../models/user.dart';

class BaseAPI {
  static String base = "http://localhost:3010";
  static String api = "$base/api";
  static Uri signupPath = Uri.parse("$api/user/register");
  static Uri loginPath = Uri.parse("$api/user/login");

  static Uri getPlacePath = Uri.parse("$api/place/one");
  static Uri acceptPlacePath = Uri.parse("$api/place/accept");
  static Uri acceptedPlacesPath = Uri.parse("$api/place/accepted");
  static Uri refusePlacesPath = Uri.parse("$api/place/refuse");

  static String googleApiKey = "AIzaSyBv2zOoqxBElmBJH4jFBieXnoDXqy_YRkw";
  static String bearerToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDI2OWI2ODgyNThlZGRhZTNkZGVlZTYiLCJ0b2tlbklkIjoiNjQyOTM5OTdmODI4N2RkNjYyNmE4MjExIiwidHlwZSI6Im5vcm1hbCIsImlhdCI6MTY4MDQyMzMxOX0.6hwsAg7UYX4R2OLNUC__7soeEzuuegZqYuZXEZLRRo0";

  // more routes
  static Map<String, String> headers = {
    'Content-Type': "application/json; charset=UTF-8",
    'Authorization': "Bearer $bearerToken"
  };

  static Future<Response> signUpWithEmail(UserModel user) async {
    return await http.Client()
        .post(signupPath, headers: headers, body: jsonEncode(user));
  }

  static Future<Response> signInWithEmail(UserLoginModel userLogin) async {
    return await http.Client()
        .post(loginPath, headers: headers, body: jsonEncode(userLogin));
  }

  static Future<Response> getRequestedPlace(RequestPlace requestPlace) async {
    var json = jsonEncode(requestPlace);
    return await http.Client().post(getPlacePath, headers: headers, body: json);
  }

  static Future<Response> acceptPlace(String placeId) async {
    var body = {placeId: placeId};
    var json = jsonEncode(body);

    return await http.Client()
        .post(acceptPlacePath, headers: headers, body: json);
  }

  static Future<Response> getAcceptedPlaces() async {
    return await http.Client().get(acceptedPlacesPath, headers: headers);
  }

  static Future<Response> refusePlace(String docId) async {
    var body = {'docId': docId};
    var json = jsonEncode(body);
    return await http.Client()
        .post(refusePlacesPath, headers: headers, body: json);
  }
}
