import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:whatodo/providers/user.dart';
import 'package:whatodo/screens/ad_video_player.dart';
import 'package:whatodo/screens/purchase_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/add_user.dart';
import '../screens/help_screen.dart';

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  const AppBarComponent({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.black,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: getAlignment(),
        children: [
          if (ModalRoute.of(context)?.canPop == true) getBackButton(),
          GestureDetector(
            onTap: () => goToPurchaseScreen(),
            child: Row(
              children: [
                const ImageIcon(AssetImage(Constants.tokenIcon),
                    color: Colors.black),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Consumer<UserProvider>(
                    builder: (context, value, child) {
                      return Text("${value.token} ${getTokenText(value.token)}",
                          style: Constants.activityHeaderTextStyle);
                    },
                  ),
                )
              ],
            ),
          ),
          if (ModalRoute.of(context)?.canPop == false)
            GestureDetector(
              onTap: () => showAd(),
              child: Consumer<UserProvider>(
                builder: (context, value, child) {
                  if (value.enableAdVideo) {
                    return getEnableVideoAd();
                  } else {
                    return getDisableVideoAd();
                  }
                },
              ),
            ),
          if (ModalRoute.of(context)?.canPop == false)
            GestureDetector(
              onTap: () => showSponsorship(),
              child: Row(
                children: const [
                  ImageIcon(AssetImage(Constants.addPeopleIcon), color: Colors.black),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text("+1",
                        style: Constants.activityHeaderTextStyle),
                  )
                ],
              ),
            ),
          if (Navigator.of(context).canPop() == false)
            GestureDetector(
              onTap: () => goToHelpScreen(),
              child: const ImageIcon(AssetImage(Constants.helpIcon),
                  color: Colors.black),
            )
        ],
      ),
    );
  }

  String getTokenText(int token){
    return token > 1 ? AppLocalizations.of(context)!.tokens : AppLocalizations.of(context)!.token;
  }

  Row getDisableVideoAd() {
    return Row(
      children: [
        const ImageIcon(AssetImage(Constants.tvIcon), color: Colors.grey),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Text("+1", style: Constants.lockedTextStyle),
        )
      ],
    );
  }

  MainAxisAlignment getAlignment() {
      return ModalRoute.of(context)?.canPop == true ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween;
  }

  Row getEnableVideoAd() {
    return Row(
      children: const [
        ImageIcon(AssetImage(Constants.tvIcon), color: Colors.black),
        Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Text("+1", style: Constants.activityHeaderTextStyle),
        )
      ],
    );
  }

  showSponsorship() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const AddUserScreen(),
      ),
    );
  }

  showAd() {
    bool canStartAd =
        Provider.of<UserProvider>(context, listen: false).enableAdVideo;
    if (canStartAd) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const AdVideoPlayer(),
        ),
      );
    }
  }

  goToHelpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HelpScreen(),
      ),
    );
  }

  getBackButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const SizedBox(
          width: 25,
          child: Icon(Icons.arrow_back),
        ),
      ),
    );
  }

  goToPurchaseScreen() {
    String? currentRoute = ModalRoute.of(context)?.settings.name;

    if (currentRoute != Constants.purchaseRouteName) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const PurchaseScreen(),
            settings: const RouteSettings(name: Constants.purchaseRouteName)),
      );
    }
  }
}
