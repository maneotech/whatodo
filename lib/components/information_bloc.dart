import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatodo/models/result_place.dart';
import 'package:whatodo/services/base_api.dart';
import 'package:whatodo/services/toast.dart';

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
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                    title: resultPlaceModel.generatedOptions.priceType ==
                            PriceType.free
                        ? "Gratuit"
                        : "Payant",
                    color: Constants.thirdColor,
                    iconPath: resultPlaceModel.generatedOptions.priceType ==
                            PriceType.free
                        ? Constants.freeIcon
                        : Constants.notFreeIcon,
                    isActive: true,
                    onTap: null),
                getActivityContainer(),
                ActivityContainer(
                  title: "Voir dans Maps",
                  color: Constants.primaryColor,
                  iconPath: Constants.mapIcon,
                  isActive: true,
                  onTap: () => openMap(),
                )
              ],
            ),
            getYesNoButtons(context)
          ]),
        ),
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

  Row getYesNoButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child:
                ActionButton(onTap: () => acceptPlace(context), title: "Oui")),
        const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
        Expanded(
            child:
                ActionButton(onTap: () => refusePlace(context), title: "Non"))
      ],
    );
  }

  refusePlace(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  acceptPlace(BuildContext context) async {
    var res = await BaseAPI.acceptPlace(resultPlaceModel.id);

    if (res.statusCode == 200) {
      ToastService.showSuccess("Ce lieu a été ajouté à votre historique");
      if (context.mounted) {
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      }
    } else {
      ToastService.showError("Une erreur est survenue, merci de réessayer");
    }
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
