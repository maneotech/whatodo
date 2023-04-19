import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:whatodo/screens/login_email.dart';
import 'package:whatodo/services/base_api.dart';
import 'package:whatodo/services/login_service.dart';
import 'package:whatodo/services/toast.dart';

import '../components/signin_button.dart';
import '../components/signin_picture_title.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/request_user.dart';
import '../models/user.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      SignInButton(
        button: Buttons.facebook,
        onPressed: _handleSignInFacebook,
      ),
      if (!kIsWeb)
        if (Platform.isIOS)
          SignInButton(
            button: Buttons.apple,
            onPressed: _handleSignInApple,
          ),
      SignInButton(
        button: Buttons.google,
        onPressed: _handleSignInGoogle,
      ),
      SignInButton(
        button: Buttons.email,
        onPressed: () => _handleSignInEmail(),
      ),
    ];

    return SignInPictureTitle(widgets: buttons);
  }

  Future<void> _handleSignInGoogle() async {
    try {
      var result = await _googleSignIn.signIn();
      if (result != null) {
        final GoogleSignInAuthentication googleAuth =
            await result.authentication;

        String token = googleAuth.accessToken.toString();
        String firstname = result.displayName!.split(' ').first;
        String email = result.email;

        UserRequestModel userModel = UserRequestModel(firstname, email, token);

        loginWithThirdPart(userModel, UserThirdPart.google);
      } else {
        print("result error: ");
        print(result);

        ToastService.showError(AppLocalizations.of(context)!.internalError);
      }
    } catch (error) {
      print(error);
      ToastService.showError(AppLocalizations.of(context)!.internalError);
    }
  }

  Future<void> _handleSignInApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print(credential);
      String firstname = credential.givenName!;
      String email = credential.email!;
      String token = credential.identityToken!;
      UserRequestModel userModel = UserRequestModel(firstname, email, token);

      loginWithThirdPart(userModel, UserThirdPart.google);
    } catch (error) {
      ToastService.showError(AppLocalizations.of(context)!.internalError);
    }
  }

  Future<void> _handleSignInFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      final userData = await FacebookAuth.instance.getUserData(
        fields: "first_name,email",
      );

      final String firstname = userData["first_name"];
      final String email = userData["email"];
      final String token = accessToken.token;

      UserRequestModel userModel = UserRequestModel(firstname, email, token);

      loginWithThirdPart(userModel, UserThirdPart.facebook);
    } else {
      ToastService.showError(AppLocalizations.of(context)!.internalError);
    }
  }

  loginWithThirdPart(
      UserRequestModel userModel, UserThirdPart thirdPart) async {
    if (thirdPart == UserThirdPart.apple) {
      var response = await BaseAPI.signInWithApple(userModel);
      LoginService.handleLoginResponse(response, context);
    } else if (thirdPart == UserThirdPart.facebook) {
      var response = await BaseAPI.signInWithFacebook(userModel);
      LoginService.handleLoginResponse(response, context);
    } else {
      var response = await BaseAPI.signInWithGoogle(userModel);
      LoginService.handleLoginResponse(response, context);
    }
  }

  _handleSignInEmail() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const LoginEmailScreen()));
  }
}
