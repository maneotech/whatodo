import 'package:flutter/material.dart';

import '../constants/constant.dart';
import '../models/result_place.dart';
import '../services/activity.dart';
import '../services/alert.dart';
import '../utils/enum_filters.dart';
import 'activity_container.dart';
import 'activity_header_text.dart';

class HistoryBloc extends StatelessWidget {
  final ResultPlaceModel resultPlaceModel;
  final Function onDeleteActivity;

  const HistoryBloc(
      {super.key,
      required this.resultPlaceModel,
      required this.onDeleteActivity});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 5.0, left: 7.0, right: 5.0, bottom: 30.0),
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child:
                              ActivityHeaderText(text: resultPlaceModel.name)),
                      Column()
                    ],
                  ),
                  Expanded(
                    child: Text(
                      resultPlaceModel.address,
                      style: Constants.normalBlackTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      children: [
                        ActivityContainer(
                          title:
                              "${resultPlaceModel.generatedOptions.travellingDuration.toString()} minutes à pied",
                          color: Constants.primaryColor,
                          iconPath: Constants.walkIcon,
                          onTap: null,
                          changeColorOnTap: false,
                          isActive: true,
                        ),
                        ActivityContainer(
                            title:
                                resultPlaceModel.generatedOptions.priceType ==
                                        PriceType.free
                                    ? "Gratuit"
                                    : "Payant",
                            color: Constants.thirdColor,
                            iconPath:
                                resultPlaceModel.generatedOptions.priceType ==
                                        PriceType.free
                                    ? Constants.freeIcon
                                    : Constants.notFreeIcon,
                            changeColorOnTap: false,
                            isActive: true,
                            onTap: null),
                        getActivityContainer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => onDeleteActivity(),
            child: const Icon(
              Icons.remove_circle,
              color: Colors.black,
              size: 12,
            ),
          ),
        ),
      ],
    );
  }

  ActivityContainer getActivityContainer() {
    switch (resultPlaceModel.generatedOptions.activityType) {
      case ActivityType.culturel:
        return ActivityService.getCulturelBloc(null, true);

      case ActivityType.bar:
        return ActivityService.getBarBloc(null, true);

      case ActivityType.restaurant:
        return ActivityService.getRestaurantBloc(null, true);

      case ActivityType.sport:
        return ActivityService.getSportBloc(null, true);

      case ActivityType.shopping:
        return ActivityService.getShoppingBloc(null, true);

      case ActivityType.snacking:
        return ActivityService.getSnackingBloc(null, true);

      default:
        return ActivityService.getCulturelBloc(null, true);
    }
  }
}
