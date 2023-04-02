import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/components/signup_textinput.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:whatodo/models/response/response_error.dart';
import 'package:whatodo/providers/auth.dart';
import 'package:whatodo/screens/login.dart';
import 'package:whatodo/screens/login_email.dart';
import 'package:whatodo/services/base_api.dart';
import 'package:whatodo/services/form_validation.dart';
import 'package:whatodo/services/toast.dart';

import '../components/color_ button.dart';
import '../models/request_user.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _ScreenState();
}

class _ScreenState extends State<SignupScreen> {
  TextEditingController controllerFirstname = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Constants.paddingLogin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Création de compte', style: Constants.signupTitle),
            Column(
              children: [
                SignupTextInput(
                    title: "Prénom",
                    label: "Entrez votre prénom",
                    isPassword: false,
                    controller: controllerFirstname),
                SignupTextInput(
                    title: "Email",
                    label: "Entrez votre email",
                    isPassword: false,
                    controller: controllerEmail),
                SignupTextInput(
                    title: "Mot de passe",
                    label: "Entrez mot de passe",
                    isPassword: true,
                    controller: controllerPassword),
                SignupTextInput(
                    title: "Confirmation du mot de passe",
                    label: "Entrez votre mot de passe à nouveau",
                    isPassword: true,
                    controller: controllerConfirmPassword),
              ],
            ),
            ColorButton(
              text: "S'inscrire",
              onPressed: () => signupWithEmail(),
            ),
            Padding(
              padding: Constants.paddingTop,
              child: TextButton(
                child: const Text("Revenir à la page de connexion"),
                onPressed: () => goToLogin(),
              ),
            )
          ],
        ),
      ),
    );
  }

  goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginScreen(),
      ),
    );
  }

    goToLoginEmail() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginEmailScreen(),
      ),
    );
  }

  signupWithEmail() async {
    if (FormValidation.isFormValid(controllerFirstname.text, controllerEmail.text, controllerPassword.text)) {
      UserRequestModel user = UserRequestModel(controllerFirstname.text, controllerEmail.text,
          controllerPassword.text);
      var res = await BaseAPI.signUpWithEmail(user);
      if (res.statusCode == 200) {
        ToastService.showSuccess(
            "Votre compte a bien été créé. Veuillez vous connecter");
        goToLoginEmail();
      } else {
        ResponseError body = ResponseError.fromReqBody(res.body);
        if (body.error == 58) {
          ToastService.showError(
              "Cette adresse email est déjà utilisée.");
        } else {
          ToastService.showError(
              "Une erreur interne est survenue. Veuillez réessayer.");
        }
      }
    }
  }
}
