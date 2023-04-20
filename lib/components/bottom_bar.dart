import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:whatodo/constants/constant.dart';

class CustomBottomBar extends StatelessWidget {
  final Function onDestinationSelected;

  const CustomBottomBar({super.key, required this.onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
      border: Border.all(color: Colors.white, width: 2),
      borderRadius: BorderRadius.circular(10),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onDestinationSelected(0),
                child: Container(
                  decoration: decoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: AssetImage(Constants.whatodoIcon),
                        height: 20,
                      ),
                      Text(
                        "Whatodo",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onDestinationSelected(1),
                child: Container(
                  decoration: decoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ImageIcon(AssetImage(Constants.historyIcon), size: 20),
                      Text(
                        AppLocalizations.of(context)!.history,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
