import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatodo/models/result_place.dart';

import '../constants/constant.dart';
import '../services/activity.dart';
import '../services/toast.dart';
import '../services/utils.dart';
import '../utils/enum_filters.dart';
import 'activity_container.dart';

class InformationBlocSquares extends StatelessWidget {
  final ResultPlaceModel resultPlaceModel;

  const InformationBlocSquares({super.key, required this.resultPlaceModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Row(
        children: [
          ActivityService.getActivityContainer(
              resultPlaceModel.generatedOptions.activityType),
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
            title: "Voir dans Maps",
            color: Constants.primaryColor,
            iconPath: Constants.mapIcon,
            isActive: true,
            onTap: () => openMap(),
          )
        ],
      ),
    );
  }

  Future<void> openMap() async {
    String placeId = resultPlaceModel.placeId;
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=Google&query_place_id=$placeId';

    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      ToastService.showError("Impossible d'ouvrir la map");
    }
  }
}
