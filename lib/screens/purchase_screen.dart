import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatodo/components/action_button.dart';
import 'package:whatodo/components/app_bar.dart';
import 'package:whatodo/services/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/price_container.dart';
import '../constants/constant.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(AppLocalizations.of(context)!.purchaseText1,
                style: Constants.bigTextStyle),
            Text(AppLocalizations.of(context)!.purchaseText2, style: Constants.bigTextStyle),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: SizedBox(
                height: 125,
                child: Row(
                  children: getFirstPriceBlocs(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: Text(
                  AppLocalizations.of(context)!.purchaseText3,
                  style: Constants.bigTextStyle),
            ),
            SizedBox(
              height: 125,
              child: Row(
                children: getSecondPriceBlocs(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ActionButton(
                  title: AppLocalizations.of(context)!.restorePurchase, onTap: () => null),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => launchTerms(),
                  child: Text(AppLocalizations.of(context)!.terms),
                ),
                TextButton(
                  onPressed: () => launchPolicy(context),
                  child: Text(AppLocalizations.of(context)!.policy),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  launchPolicy(BuildContext context) async {
    if (await canLaunchUrl(Uri.parse(Constants.policyUrl))) {
      await launchUrl(Uri.parse(Constants.policyUrl));
    } else {
      ToastService.showError(
          AppLocalizations.of(context)!.internalError);
    }
  }

  launchTerms() async {
    if (await canLaunchUrl(Uri.parse(Constants.termsUrl))) {
      await launchUrl(Uri.parse(Constants.termsUrl));
    } else {
      ToastService.showError(
          "Une erreur interne est survenue, merci de réessayer");
    }
  }

  getFirstPriceBlocs(BuildContext context) {
    return [
      PriceContainer(
        title: "1 ${AppLocalizations.of(context)!.token}",
        color: Constants.primaryColor,
        iconPath: Constants.tokenIcon,
        isActive: true,
        onTap: () => null,
        price: '1,99 €',
      ),
      PriceContainer(
        title: "5 ${AppLocalizations.of(context)!.tokens}",
        color: Constants.thirdColor,
        iconPath: Constants.tokenIcon,
        isActive: true,
        price: "9,49 €",
        discount: "-5%",
        onTap: () => null,
      ),
      PriceContainer(
        title: "10 ${AppLocalizations.of(context)!.tokens}",
        color: Constants.secondaryColor,
        iconPath: Constants.tokenIcon,
        isActive: true,
        price: "17,99 €",
        discount: "-10%",
        onTap: () => null,
      ),
    ];
  }

  getSecondPriceBlocs(BuildContext context) {
    return [
      PriceContainer(
        title: "20 ${AppLocalizations.of(context)!.tokens}",
        color: Constants.primaryColor,
        iconPath: Constants.tokenIcon,
        isActive: true,
        price: "33.99 €",
        discount: "-15%",
        onTap: () => null,
      ),
      PriceContainer(
        title: "40 ${AppLocalizations.of(context)!.tokens}",
        color: Constants.thirdColor,
        iconPath: Constants.tokenIcon,
        isActive: true,
        price: "55.99 €",
        discount: "-30%",
        onTap: () => null,
      ),
    ];
  }
}
