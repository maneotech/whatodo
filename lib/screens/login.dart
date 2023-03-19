import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whatodo/screens/login_email.dart';
import 'package:whatodo/screens/signup.dart';

import '../components/signin_button.dart';
import '../components/signin_picture_title.dart';
import '../constants/constant.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
  ],
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  GoogleSignInAccount? _currentGoogleUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentGoogleUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignInGoogle() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignInApple() async {}

  Future<void> _handleSignInFacebook() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      print(accessToken);
    } else {
      print(result.status);
      print(result.message);
    }
  }

  _handleSignInEmail() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const LoginEmailScreen()));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      SignInButton(
        button: Buttons.facebook,
        onPressed: _handleSignInFacebook,
      ),
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
}
