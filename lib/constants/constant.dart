import 'package:flutter/material.dart';

class Constants {
  static const String sharedPrefKeyLanguage = "language";
  static const String sharedPrefKeyJwt = "jwt";
  static const String sharedPrefKeyLat = "lat";
  static const String sharedPrefKeyLng = "lng";
  static const String sharedPrefKeyAddress = "address";
  static const String sharedPrefKeyFirstOpenApp = "firstopen";

  static const TextStyle defaultTextStyle = TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.black);

  static const TextStyle signupTitle = TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black);

  static const TextStyle activityTitleTextStyle =
      TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: "Hellix");

  static const TextStyle normalBlackTextStyle =
      TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: "Hellix");

  static const TextStyle rankingNumberTextStyle = TextStyle(
      fontSize: 10,
      color: Colors.black,
      fontStyle: FontStyle.italic,
      fontFamily: "Hellix");

  static const TextStyle discountTextStyle = TextStyle(
      fontSize: 10,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontFamily: "Hellix");

  static const TextStyle activityHeaderTextStyle = TextStyle(
      fontSize: 15.0,
      color: Colors.black,
      fontFamily: "Hellix",
      fontWeight: FontWeight.w500);

  static const TextStyle timeNumbersTextStyle = TextStyle(
      fontSize: 20.0,
      color: Colors.white,
      fontFamily: "Hellix",
      fontWeight: FontWeight.w700);

  static const TextStyle titlePlaceTextStyle = TextStyle(
      fontSize: 20.0,
      color: Colors.black,
      fontFamily: "Hellix",
      fontWeight: FontWeight.w700);

  static const TextStyle addressTextStyle = TextStyle(
      fontSize: 13.0,
      color: Colors.white,
      fontFamily: "Hellix",
      fontWeight: FontWeight.w700);

  static TextStyle lockedTextStyle = TextStyle(
      fontSize: 15.0,
      color: Colors.black.withOpacity(0.5),
      fontFamily: "Hellix",
      fontStyle: FontStyle.italic);

  static TextStyle bigTextStyle = const TextStyle(
      fontSize: 20.0,
      color: Colors.black,
      fontFamily: "Hellix",
      fontWeight: FontWeight.w500);

  static const EdgeInsets paddingButtons = EdgeInsets.all(10.0);
  static const EdgeInsets paddingLogin =
      EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0);
  static const EdgeInsets paddingTop = EdgeInsets.only(top: 40.0);

  static const EdgeInsets paddingActivityTitle =
      EdgeInsets.only(top: 20.0, bottom: 5.0);
  static const Color primaryColor = Color.fromRGBO(255, 105, 61, 1.0);
  static const Color secondaryColor = Color(0xff7925E9);
  static const Color thirdColor = Color(0xff10AC70);
  static const Color lightOutlinedGreenColor = Color(0xff1DD193);

  static const double heightContainer = 80.0;

  static const String loginImage = "assets/images/login.jpg";

  static const String openingImage = "assets/images/opening.jpg";
  static const String successSound = "sounds/success.wav";

  static const String barIcon = "assets/icons/bar.png";
  static const String bicycleIcon = "assets/icons/bicycle.png";
  static const String carIcon = "assets/icons/car.png";
  static const String randomIcon = "assets/icons/random.png";
  static const String freeIcon = "assets/icons/free.png";
  static const String notFreeIcon = "assets/icons/notfree.png";
  static const String restaurantIcon = "assets/icons/restaurant.png";
  static const String snackingIcon = "assets/icons/snacking.png";
  static const String shoppingIcon = "assets/icons/shopping.png";
  static const String discoveringIcon = "assets/icons/discovering.png";
  static const String walkIcon = "assets/icons/walk.png";
  static const String tokenIcon = "assets/icons/token.png";
  static const String helpIcon = "assets/icons/help.png";
  static const String mapIcon = "assets/icons/map.png";
  static const String whatodoIcon = "assets/icons/whatodo.png";
  static const String historyIcon = "assets/icons/history.png";
  static const String addPeopleIcon = "assets/icons/add-people.png";
  static const String tvIcon = "assets/icons/tv.png";
  static const String timeIcon = "assets/icons/time.png";
  static const String locationIcon = "assets/icons/location.png";

  static const String termsUrl = "https://maneotech.fr/terms-of-service.html";
  static const String policyUrl = "https://maneotech.fr/policy.html";
  static const String urlPictureGoogle =
      "https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=";


  static const String androidKey = "&key=AIzaSyCGnbHNMOKZjlpDW0xiEgAHPxLagEhuTOE";
  static const String iosKey = "&key=AIzaSyCGnbHNMOKZjlpDW0xiEgAHPxLagEhuTOE";

  static const String purchaseRouteName = "shop";
}
