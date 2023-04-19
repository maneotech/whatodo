import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatodo/models/result_place.dart';
import 'package:whatodo/services/base_api.dart';
import 'package:whatodo/services/toast.dart';

import '../constants/constant.dart';
import '../services/activity.dart';
import '../services/utils.dart';
import '../utils/enum_filters.dart';
import 'action_button.dart';
import 'activity_container.dart';
import 'activity_header_text.dart';
import 'information_bloc_squares.dart';

class InformationBloc extends StatelessWidget {
  final ResultPlaceModel resultPlaceModel;

  const InformationBloc({
    super.key,
    required this.resultPlaceModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
              children: const [
                ActivityHeaderText(text: "Informations"),
              ],
            ),
            InformationBlocSquares(resultPlaceModel: resultPlaceModel),
            getYesNoButtons(context)
          ]),
        ),
      ),
    );
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
}
