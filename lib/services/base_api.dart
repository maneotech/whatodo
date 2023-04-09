import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:whatodo/models/request_place.dart';
import 'package:whatodo/models/user_login.dart';

import '../models/request_user.dart';

class BaseAPI {
  static String base = "http://192.168.0.15:3010";
  static String api = "$base/api";
  static Uri signupPath = Uri.parse("$api/user/register");
  static Uri loginPath = Uri.parse("$api/user/login");
  static Uri loginFacebookPath = Uri.parse("$api/user/login/facebook");
  static Uri loginGooglePath = Uri.parse("$api/user/login/google");
  static Uri loginApplePath = Uri.parse("$api/user/login/apple");

  static Uri getPlacePath = Uri.parse("$api/place/one");
  static Uri acceptPlacePath = Uri.parse("$api/place/accept");
  static Uri acceptedPlacesPath = Uri.parse("$api/place/accepted");
  static Uri refusePlacesPath = Uri.parse("$api/place/refuse");

  static Uri startVideoUrl = Uri.parse("$api/ad/video/start");
  static Uri endVideoUrl = Uri.parse("$api/ad/video/end");
  static Uri clickVideoUrl = Uri.parse("$api/ad/video/click");

  static Uri getHomeUrl = Uri.parse("$api/home/info");

  static Uri sponsorshipNotifiedUrl = Uri.parse("$api/ad/sponsorship/notify");
  static Uri createSponsorshipUrl = Uri.parse("$api/ad/sponsorship/create");

  static String googleApiKey = "AIzaSyBv2zOoqxBElmBJH4jFBieXnoDXqy_YRkw";
  static String bearerToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDI2OWI2ODgyNThlZGRhZTNkZGVlZTYiLCJ0b2tlbklkIjoiNjQyYzYxOTA3OWQxYTIzMzIyNzA0Yzg5IiwidHlwZSI6Im5vcm1hbCIsImlhdCI6MTY4MDYzMDE2MH0.14J1wPDXK1WPdZnndoVKBD0C_B7Ecowx1Unf_LWU8NE";

  // more routes
  static Map<String, String> headers = {
    'Content-Type': "application/json; charset=UTF-8",
    'Authorization': "Bearer $bearerToken"
  };

  /* ************** SIGNIN / LOGIN ***************/
  static Future<Response> signUpWithEmail(UserRequestModel user) async {
    return await http.Client()
        .post(signupPath, headers: headers, body: jsonEncode(user));
  }

  static Future<Response> signInWithEmail(UserLoginModel userLogin) async {
    return await http.Client()
        .post(loginPath, headers: headers, body: jsonEncode(userLogin));
  }

  static Future<Response> signInWithGoogle(UserRequestModel userLogin) async {
    return await http.Client()
        .post(loginGooglePath, headers: headers, body: jsonEncode(userLogin));
  }

  static Future<Response> signInWithFacebook(UserRequestModel userLogin) async {
    return await http.Client()
        .post(loginFacebookPath, headers: headers, body: jsonEncode(userLogin));
  }

  static Future<Response> signInWithApple(UserRequestModel userLogin) async {
    return await http.Client()
        .post(loginApplePath, headers: headers, body: jsonEncode(userLogin));
  }

  /* **************** PLACE **************** */
  static Future<Response> getRequestedPlace(RequestPlace requestPlace) async {
    var json = jsonEncode(requestPlace);
    return await http.Client().post(getPlacePath, headers: headers, body: json);
  }

  static Future<Response> acceptPlace(String docId) async {
    var body = {'docId': docId};
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

  /* ******************************** AD ***************/
  static Future<Response> startVideo(String platform, String language) async {
    var body = {'platform': platform, 'language': language};
    var json = jsonEncode(body);

    return await http.Client()
        .post(startVideoUrl, headers: headers, body: json);
  }

  static Future<Response> endVideo(String docId) async {
    var body = {'docId': docId};
    var json = jsonEncode(body);

    return await http.Client().post(endVideoUrl, headers: headers, body: json);
  }

  static Future<Response> clickVideo(String docId) async {
    var body = {'docId': docId};
    var json = jsonEncode(body);

    return await http.Client()
        .post(clickVideoUrl, headers: headers, body: json);
  }

  /* ************** HOME ***************/
  static Future<Response> getHome() async {
    return await http.Client().get(getHomeUrl, headers: headers);
  }

  /* ************** SPONSORHIP ***************/
  static Future<Response> sponsorshipHasBeenNotified(
      String lastSponsorshipEmail) async {
    var body = {'lastSponsorshipEmail': lastSponsorshipEmail};
    var json = jsonEncode(body);

    return await http.Client()
        .post(sponsorshipNotifiedUrl, headers: headers, body: json);
  }

  static Future<Response> createSponsorship(String email) async {
    var body = {'email': email};
    var json = jsonEncode(body);

    return await http.Client()
        .post(createSponsorshipUrl, headers: headers, body: json);
  }
}
