import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:whatodo/models/request_place.dart';
import 'package:whatodo/models/user_login.dart';

import '../models/request_user.dart';
import '../providers/auth.dart';

class BaseAPI {

  //static String base = "http://localhost:3010";
  static String base = "https://api.dev.whatodo.maneotech.fr";

  static String api = "$base/api";
  static Uri signupPath = Uri.parse("$api/user/register");
  static Uri loginPath = Uri.parse("$api/user/login");
  static Uri loginFacebookPath = Uri.parse("$api/user/login/facebook");
  static Uri loginGooglePath = Uri.parse("$api/user/login/google");
  static Uri loginApplePath = Uri.parse("$api/user/login/apple");

  static Uri getPlacePath = Uri.parse("$api/place/one");
  static Uri acceptPlacePath = Uri.parse("$api/place/accept");
  static Uri allPlacesPath = Uri.parse("$api/place/all");
  static Uri refusePlacesPath = Uri.parse("$api/place/refuse");

  static Uri startVideoUrl = Uri.parse("$api/ad/video/start");
  static Uri endVideoUrl = Uri.parse("$api/ad/video/end");
  static Uri clickVideoUrl = Uri.parse("$api/ad/video/click");

  static Uri getHomeUrl = Uri.parse("$api/home/info");

  static Uri sponsorshipNotifiedUrl = Uri.parse("$api/ad/sponsorship/notify");
  static Uri createSponsorshipUrl = Uri.parse("$api/ad/sponsorship/create");


  /* ************** SIGNIN / LOGIN ***************/
  static Future<Response> signUpWithEmail(UserRequestModel user) async {
    return await http.Client()
        .post(signupPath, headers: AuthProvider.getHeaders(), body: jsonEncode(user));
  }

  static Future<Response> signInWithEmail(UserLoginModel userLogin) async {
    return await http.Client()
        .post(loginPath, headers: AuthProvider.getHeaders(), body: jsonEncode(userLogin));
  }

  static Future<Response> signInWithGoogle(UserRequestModel userLogin) async {
    return await http.Client()
        .post(loginGooglePath, headers: AuthProvider.getHeaders(), body: jsonEncode(userLogin));
  }

  static Future<Response> signInWithFacebook(UserRequestModel userLogin) async {
    return await http.Client()
        .post(loginFacebookPath, headers: AuthProvider.getHeaders(), body: jsonEncode(userLogin));
  }

  static Future<Response> signInWithApple(UserRequestModel userLogin) async {
    return await http.Client()
        .post(loginApplePath, headers: AuthProvider.getHeaders(), body: jsonEncode(userLogin));
  }

  /* **************** PLACE **************** */
  static Future<Response> getRequestedPlace(RequestPlace requestPlace) async {
    var json = jsonEncode(requestPlace);
    return await http.Client().post(getPlacePath, headers: AuthProvider.getHeaders(), body: json);
  }

  static Future<Response> acceptPlace(String docId) async {
    var body = {'docId': docId};
    var json = jsonEncode(body);

    return await http.Client()
        .post(acceptPlacePath, headers: AuthProvider.getHeaders(), body: json);
  }

  static Future<Response> getAllPlaces() async {
    return await http.Client().get(allPlacesPath, headers: AuthProvider.getHeaders());
  }

  static Future<Response> refusePlace(String docId) async {
    var body = {'docId': docId};
    var json = jsonEncode(body);
    return await http.Client()
        .post(refusePlacesPath, headers: AuthProvider.getHeaders(), body: json);
  }

  /* ******************************** AD ***************/
  static Future<Response> startVideo(String platform, String language) async {
    var body = {'platform': platform, 'language': language};
    var json = jsonEncode(body);

    return await http.Client()
        .post(startVideoUrl, headers: AuthProvider.getHeaders(), body: json);
  }

  static Future<Response> endVideo(String docId) async {
    var body = {'docId': docId};
    var json = jsonEncode(body);

    return await http.Client().post(endVideoUrl, headers: AuthProvider.getHeaders(), body: json);
  }

  static Future<Response> clickVideo(String docId) async {
    var body = {'docId': docId};
    var json = jsonEncode(body);

    return await http.Client()
        .post(clickVideoUrl, headers: AuthProvider.getHeaders(), body: json);
  }

  /* ************** HOME ***************/
  static Future<Response> getHome() async {
    return await http.Client().get(getHomeUrl, headers: AuthProvider.getHeaders());
  }

  /* ************** SPONSORHIP ***************/
  static Future<Response> sponsorshipHasBeenNotified(
      String lastSponsorshipEmail) async {
    var body = {'lastSponsorshipEmail': lastSponsorshipEmail};
    var json = jsonEncode(body);

    return await http.Client()
        .post(sponsorshipNotifiedUrl, headers: AuthProvider.getHeaders(), body: json);
  }

  static Future<Response> createSponsorship(String email) async {
    var body = {'email': email};
    var json = jsonEncode(body);

    return await http.Client()
        .post(createSponsorshipUrl, headers: AuthProvider.getHeaders(), body: json);
  }
}
