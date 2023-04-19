import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                       Icon(Icons.play_arrow, color: Colors.white),
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
                      const Icon(Icons.tune, color: Colors.white),
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
