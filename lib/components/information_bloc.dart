import 'package:flutter/material.dart';
import 'package:whatodo/models/result_place.dart';

import '../constants/constant.dart';
import '../services/activity.dart';
import '../utils/enum_filters.dart';
import 'action_button.dart';
import 'activity_container.dart';
import 'activity_header_text.dart';

class InformationBloc extends StatelessWidget {
  final ResultPlaceModel resultPlaceModel;

  const InformationBloc({super.key, required this.resultPlaceModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0, right: 7.0, bottom: 30.0),
      child: Container(
        height: 280,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              children: const [
                ActivityHeaderText(text: "Informations"),
              ],
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: [
                ActivityContainer(
                  title:
                      "${resultPlaceModel.travellingDuration.toString()} minutes à pied",
                  color: Constants.primaryColor,
                  iconPath: Constants.walkIcon,
                  onTap: null,
                  isActive: true,
                ),
                ActivityContainer(
                    title: resultPlaceModel.priceType == PriceType.free
                        ? "Gratuit"
                        : "Payant",
                    color: Constants.thirdColor,
                    iconPath: resultPlaceModel.priceType == PriceType.free
                        ? Constants.freeIcon
                        : Constants.notFreeIcon,
                    isActive: true,
                    onTap: null),
                getActivityContainer(),
              ],
            ),
            getYesNoButtons()
          ]),
        ),
      ),
    );
  }

  Row getYesNoButtons() {
    return Row(
      children: [
        Expanded(child: ActionButton(onTap: () => null, title: "Oui")),
        const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
        Expanded(child: ActionButton(onTap: () => null, title: "Non"))
      ],
    );
  }

  ActivityContainer getActivityContainer() {
    switch (resultPlaceModel.activityType) {
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

      case ActivityType.grocery:
        return ActivityService.getGroceryBloc(null, true);

      default:
        return ActivityService.getCulturelBloc(null, true);
    }
  }
}
