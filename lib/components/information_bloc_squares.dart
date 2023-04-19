import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatodo/models/result_place.dart';

import '../constants/constant.dart';
import '../services/toast.dart';
import '../services/utils.dart';
import '../utils/enum_filters.dart';
import 'activity_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InformationBlocSquares extends StatelessWidget {
  final ResultPlaceModel resultPlaceModel;

  const InformationBlocSquares({super.key, required this.resultPlaceModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Row(
        children: [
          getActivityContainer(
              resultPlaceModel.generatedOptions.activityType, context),
          ActivityContainer(
              title:
                  "< ${UtilService.getMinutesFromHoursMinutes(resultPlaceModel.generatedOptions.maxHour, resultPlaceModel.generatedOptions.maxMin)} minutes",
              color: Constants.thirdColor,
              iconPath: resultPlaceModel.generatedOptions.movingType ==
                      MovingType.byBicycle
                  ? Constants.bicycleIcon
                  : resultPlaceModel.generatedOptions.movingType ==
                          MovingType.byWalk
                      ? Constants.walkIcon
                      : Constants.carIcon,
              isActive: true,
              onTap: null),
          ActivityContainer(
            title: AppLocalizations.of(context)!.seeMaps,
            color: Constants.primaryColor,
            iconPath: Constants.mapIcon,
            isActive: true,
            onTap: () => openMap(context),
          )
        ],
      ),
    );
  }

  ActivityContainer getActivityContainer(ActivityType activityType, BuildContext context) {
    var title = AppLocalizations.of(context)!.random;
    var iconPath = Constants.randomIcon;

    switch (activityType) {
      case ActivityType.random:
        title = AppLocalizations.of(context)!.random;
        iconPath = Constants.randomIcon;
        break;

      case ActivityType.bar:
        title = AppLocalizations.of(context)!.bar;
        iconPath = Constants.barIcon;
        break;
      case ActivityType.restaurant:
        title = AppLocalizations.of(context)!.restaurant;
        iconPath = Constants.restaurantIcon;
        break;
      case ActivityType.discovering:
        title = AppLocalizations.of(context)!.discovering;
        iconPath = Constants.discoveringIcon;
        break;
      case ActivityType.shopping:
        title = AppLocalizations.of(context)!.shopping;
        iconPath = Constants.shoppingIcon;
        break;
      case ActivityType.snacking:
        title = AppLocalizations.of(context)!.snacking;
        iconPath = Constants.snackingIcon;
        break;
    }

    return ActivityContainer(
        title: title,
        color: Constants.secondaryColor,
        iconPath: iconPath,
        onTap: null,
        changeColorOnTap: false,
        isActive: true);
  }

  Future<void> openMap(BuildContext context) async {
    String placeId = resultPlaceModel.placeId;
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=Google&query_place_id=$placeId';

    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      ToastService.showError(AppLocalizations.of(context)!.cannotOpenMap);
    }
  }
}
