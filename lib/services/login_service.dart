import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/services/toast.dart';

import '../models/response/response_error.dart';
import '../models/response/response_user.dart';
import '../providers/auth.dart';
import '../providers/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginService {
  static handleLoginResponse(Response res, BuildContext context) async {
    if (res.statusCode == 200) {
      if (context.mounted) {
        ResponseUser responseUser = ResponseUser.fromReqBody(res.body);

        //fix notify listener not called
        Navigator.pushReplacementNamed(context, '/');
        //end of fix

        await Provider.of<AuthProvider>(context, listen: false)
            .saveJwtToDisk(responseUser.data.token);

        await Provider.of<UserProvider>(context, listen: false)
            .setUser(responseUser.user);
      } else {
        ToastService.showError(AppLocalizations.of(context)!.internalError);
      }
    } else {
      ResponseError body = ResponseError.fromReqBody(res.body);
      if (body.error == 102) {
        ToastService.showError(AppLocalizations.of(context)!.emailOrPasswordIncorrect);
      } else if (body.error == 58) {
        ToastService.showError(AppLocalizations.of(context)!.emailAlreadyUsed);
      } else {
        ToastService.showError(
            AppLocalizations.of(context)!.internalError);
      }
    }
  }
}
