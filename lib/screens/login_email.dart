import 'package:flutter/material.dart';
import 'package:whatodo/components/signin_picture_title.dart';
import 'package:whatodo/screens/signup.dart';

import '../components/color_ button.dart';
import '../components/signup_textinput.dart';
import '../constants/constant.dart';
import '../models/user_login.dart';
import '../services/base_api.dart';
import '../services/form_validation.dart';
import '../services/login_service.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  goToSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const Text('Connexion avec email', style: Constants.signupTitle),
      SignupTextInput(
          title: "Email",
          label: "Entrez votre email",
          isPassword: false,
          controller: controllerEmail),
      SignupTextInput(
          title: "Mot de passe",
          label: "Entrez votre mot de passe",
          isPassword: true,
          controller: controllerPassword),
      ColorButton(
        text: "Se connecter",
        onPressed: () => signInWithEmail(),
      ),
      Padding(
        padding: Constants.paddingTop,
        child: TextButton(
          child:
              const Text("Pas encore inscrit ? Cliquer ici pour vous inscrire"),
          onPressed: () => goToSignUp(),
        ),
      )
    ];

    return SignInPictureTitle(widgets: children);
  }

  signInWithEmail() async {
    if (FormValidation.isFormValid(
        null, controllerEmail.text, controllerPassword.text)) {
      UserLoginModel userLogin =
          UserLoginModel(controllerEmail.text, controllerPassword.text);

      var res = await BaseAPI.signInWithEmail(userLogin);
      LoginService.handleLoginResponse(res, context);
    }
  }
}
