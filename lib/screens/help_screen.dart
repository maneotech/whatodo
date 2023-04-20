import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatodo/components/action_button.dart';
import 'package:whatodo/components/text_faq_header.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/app_bar.dart';
import '../providers/auth.dart';
import '../services/alert.dart';
import '../services/toast.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.faq,
                      style: Constants.bigTextStyle),
                  TextFaqHeader(text: AppLocalizations.of(context)!.faqq1),
                  Text(AppLocalizations.of(context)!.faqa1),
                  TextFaqHeader(text: AppLocalizations.of(context)!.faqq2),
                  Text(AppLocalizations.of(context)!.faqa2),
                  TextFaqHeader(text: AppLocalizations.of(context)!.faqq3),
                  ActionButton(
                    title: AppLocalizations.of(context)!.faqa3,
                    onTap: () => contactEmail(context),
                    height: 40,
                    alignCenter: false,
                  ),
                  TextFaqHeader(text: AppLocalizations.of(context)!.faqq4),
                  ActionButton(
                    title: AppLocalizations.of(context)!.logout,
                    onTap: () => disconnectAlert(context),
                    height: 40,
                    alignCenter: false,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  contactEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'utilities@maneotech.fr',
      queryParameters: {
        'subject': 'Whatodo-Support',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ToastService.showError(AppLocalizations.of(context)!.internalError);
    }
  }

  disconnectAlert(BuildContext context) {
    AlertService.showAlertDialogTwoButtons(
        context,
        AppLocalizations.of(context)!.yes,
        AppLocalizations.of(context)!.no,
        AppLocalizations.of(context)!.logout,
        AppLocalizations.of(context)!.logoutConfirm,
        () => disconnect(context),
        () => Navigator.pop(context));
  }

  disconnect(BuildContext context) async {
    //fix notify listener not called
    Navigator.pushReplacementNamed(context, '/');
    //end of fix

    await Provider.of<AuthProvider>(context, listen: false).logout();
  }
}
