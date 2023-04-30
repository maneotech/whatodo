import 'package:flutter/material.dart';
import 'package:whatodo/services/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormValidation {
  static bool isFormValid(
      String? firstname, String email, String password, BuildContext context) {
    if (firstname != null) {
      if (firstname.isEmpty) {
        ToastService.showError(AppLocalizations.of(context)!.firstnameEmpty);
        return false;
      }
    }

    if (email.isEmpty) {
      ToastService.showError(AppLocalizations.of(context)!.emailEmpty);
      return false;
    } else if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email) ==
        false) {
      ToastService.showError(AppLocalizations.of(context)!.emailNotValid);
      return false;
    } else if (RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~;]).{8,}$')
            .hasMatch(password) ==
        false) {
      ToastService.showError(AppLocalizations.of(context)!.passwordIncorrect, longLength: true);
      return false;
    } else if (password != password) {
      ToastService.showError(AppLocalizations.of(context)!.passwordUnMatch);
      return false;
    }

    return true;
  }
}
