import 'package:flutter/material.dart';
import 'package:whatodo/components/action_button.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelperScreen extends StatelessWidget {
  const HelperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcomeWhatodo,
                      style: Constants.titlePlaceTextStyle,
                    ),
                    Text(AppLocalizations.of(context)!.whatodoHowItWorks,
                        style: Constants.lockedTextStyle),
                    getRowContent(
                      const ImageIcon(
                        AssetImage(Constants.snackingIcon),
                        size: 60,
                      ),
                      Text(AppLocalizations.of(context)!.helper1),
                    ),
                    getRowContent(
                      Text(AppLocalizations.of(context)!.helper2),
                      const ImageIcon(
                        AssetImage(Constants.tokenIcon),
                        size: 60,
                      ),
                    ),
                    getRowContent(
                      const ImageIcon(
                        AssetImage(Constants.randomIcon),
                        size: 60,
                      ),
                      Text(
                          AppLocalizations.of(context)!.helper3),
                    ),
                    ActionButton(
                      title: AppLocalizations.of(context)!.letsGo,
                      onTap: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding getRowContent(Widget leftWidget, Widget rightWidget) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [leftWidget],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                rightWidget,
              ],
            ),
          ),
        ],
      ),
    );
  }

  getRightWidgets() {}

  getIconList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        ImageIcon(AssetImage(Constants.snackingIcon)),
        ImageIcon(AssetImage(Constants.barIcon)),
        ImageIcon(AssetImage(Constants.restaurantIcon)),
        ImageIcon(AssetImage(Constants.discoveringIcon)),
        ImageIcon(AssetImage(Constants.shoppingIcon)),
        ImageIcon(AssetImage(Constants.randomIcon)),
      ],
    );
  }

  getMovingList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        ImageIcon(AssetImage(Constants.walkIcon)),
        ImageIcon(AssetImage(Constants.bicycleIcon)),
        ImageIcon(AssetImage(Constants.carIcon)),
      ],
    );
  }
}
