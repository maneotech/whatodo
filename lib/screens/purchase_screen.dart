import 'package:flutter/material.dart';
import 'package:whatodo/components/action_button.dart';
import 'package:whatodo/components/app_bar.dart';

import '../components/activity_container.dart';
import '../components/price_container.dart';
import '../constants/constant.dart';
import '../services/activity.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Fais toi plaisir en pensant à ton bien être.",
                style: Constants.bigTextStyle),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: SizedBox(
                height: 125,
                child: Row(
                  children: getFirstPriceBlocs(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 10),
              child:
                  Text("Promotion 24h seulement !!!", style: Constants.bigTextStyle),
            ),
            SizedBox(
              height: 125,
              child: Row(
                children: getSecondPriceBlocs(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: ActionButton(
                  title: "Restaurer les achats précédents", onTap: () => null),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => {},
                  child: const Text("CGU"),
                ),
                TextButton(
                  onPressed: () => {},
                  child: const Text("Politique de confidentialité"),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  getFirstPriceBlocs() {
    return [
      PriceContainer(
        title: "1 Jeton",
        color: Constants.primaryColor,
        iconPath: Constants.tokenIcon,
        isActive: true,
        onTap: () => null,
        price: '1,99 €',
      ),
      PriceContainer(
        title: "5 Jetons",
        color: Constants.thirdColor,
        iconPath: Constants.tokenIcon,
        isActive: true,
        price: "9,49 €",
        discount: "-5%",
        onTap: () => null,
      ),
      PriceContainer(
        title: "10 Jetons",
        color: Constants.secondaryColor,
        iconPath: Constants.tokenIcon,
        isActive: true,
        price: "17,99 €",
        discount: "-10%",
        onTap: () => null,
      ),
    ];
  }

  getSecondPriceBlocs() {
    return [
      PriceContainer(
        title: "20 Jeton",
        color: Constants.primaryColor,
        iconPath: Constants.tokenIcon,
        isActive: true,
        price: "33.99 €",
        discount: "-15%",
        onTap: () => null,
      ),
      PriceContainer(
        title: "40 Jetons",
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
