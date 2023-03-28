import 'package:flutter/material.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:whatodo/screens/ad_video_player.dart';

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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              ImageIcon(AssetImage(Constants.tokenIcon), color: Colors.black),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child:
                    Text("5 Jetons", style: Constants.activityHeaderTextStyle),
              )
            ],
          ),
          GestureDetector(
            onTap: () => showAd(),
            child: Row(
              children: const [
                Icon(Icons.tv, color: Colors.black),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("+1 Jeton",
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

  showAd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const AdVideoPlayer(),
      ),
    );
  }

  goToHelpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HelpScreen(),
      ),
    );
  }
}
