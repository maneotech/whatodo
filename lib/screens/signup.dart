import 'package:flutter/material.dart';
import 'package:whatodo/components/signup_textinput.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:whatodo/models/response/response_error.dart';
import 'package:whatodo/screens/login.dart';
import 'package:whatodo/screens/login_email.dart';
import 'package:whatodo/services/base_api.dart';
import 'package:whatodo/services/form_validation.dart';
import 'package:whatodo/services/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: Constants.paddingLogin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.accountSignup,
                  style: Constants.signupTitle),
              Column(
                children: [
                  SignupTextInput(
                      title: AppLocalizations.of(context)!.firstname,
                      label: AppLocalizations.of(context)!.enterFirstname,
                      isPassword: false,
                      controller: controllerFirstname),
                  SignupTextInput(
                      title: AppLocalizations.of(context)!.email,
                      label: AppLocalizations.of(context)!.enterEmail,
                      isPassword: false,
                      controller: controllerEmail),
                  SignupTextInput(
                      title: AppLocalizations.of(context)!.password,
                      label: AppLocalizations.of(context)!.enterPassword,
                      isPassword: true,
                      controller: controllerPassword),
                  SignupTextInput(
                      title: AppLocalizations.of(context)!.confirmPassword,
                      label: AppLocalizations.of(context)!.enterConfirmPassword,
                      isPassword: true,
                      controller: controllerConfirmPassword),
                ],
              ),
              ColorButton(
                text: AppLocalizations.of(context)!.signUp,
                onPressed: () => signupWithEmail(),
              ),
              Padding(
                padding: Constants.paddingTop,
                child: TextButton(
                  child: Text(AppLocalizations.of(context)!.backToLogin),
                  onPressed: () => goToLogin(),
                ),
              )
            ],
          ),
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
    if (FormValidation.isFormValid(controllerFirstname.text,
        controllerEmail.text, controllerPassword.text, context)) {
      UserRequestModel user = UserRequestModel(controllerFirstname.text,
          controllerEmail.text, controllerPassword.text);
      var res = await BaseAPI.signUpWithEmail(user);
      if (res.statusCode == 200) {
        ToastService.showSuccess(
            AppLocalizations.of(context)!.accountHasBeenCreated);
        goToLoginEmail();
      } else {
        ResponseError body = ResponseError.fromReqBody(res.body);
        if (body.error == 58) {
          ToastService.showError(AppLocalizations.of(context)!.emailAlreadyUsed);
        } else {
          ToastService.showError(
              AppLocalizations.of(context)!.internalError);
        }
      }
    }
  }
}
