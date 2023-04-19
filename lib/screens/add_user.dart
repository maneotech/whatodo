import 'package:flutter/material.dart';
import 'package:whatodo/components/app_bar.dart';
import 'package:whatodo/services/base_api.dart';
import 'package:whatodo/services/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/action_button.dart';
import '../components/signup_textinput.dart';
import '../constants/constant.dart';
import '../models/response/response_error.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.earnFreeToken,
                style: Constants.signupTitle),
            Text(AppLocalizations.of(context)!.sponsorshipText1),
            Text(AppLocalizations.of(context)!.sponsorshipText2),
            Text(AppLocalizations.of(context)!.sponsorshipText3),
            Text(AppLocalizations.of(context)!.sponsorshipText4),
            SignupTextInput(
                title: AppLocalizations.of(context)!.email,
                label: AppLocalizations.of(context)!.enterEmailFriend,
                isPassword: false,
                controller: controllerEmail),
            ActionButton(
              title: AppLocalizations.of(context)!.invitFriend,
              onTap: () => invitUser(),
            )
          ],
        ),
      ),
    );
  }

  invitUser() async {
    String email = controllerEmail.text;
    if (email.isEmpty) {
      ToastService.showError(AppLocalizations.of(context)!.enterEmailFriendError);
      return;
    } else if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email) ==
        false) {
      ToastService.showError(AppLocalizations.of(context)!.emailNotValid);
      return;
    } else {
      final res = await BaseAPI.createSponsorship(email);
      if (res.statusCode == 200) {
        ToastService.showSuccess(
           AppLocalizations.of(context)!.invitFriendPending);
      } else {
        if (res.body.isNotEmpty) {
          var body = ResponseError.fromReqBody(res.body);
          if (body.error == 755) {
            ToastService.showError(
                AppLocalizations.of(context)!.emailAlreadySponsored);
          } else {
            ToastService.showError(
                AppLocalizations.of(context)!.internalError);
          }
        } else {
          ToastService.showError(
              AppLocalizations.of(context)!.internalError);
        }
      }
    }
  }
}
