import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:whatodo/models/result_place.dart';
import 'package:whatodo/services/base_api.dart';
import 'package:whatodo/services/toast.dart';

import 'action_button.dart';
import 'activity_header_text.dart';
import 'information_bloc_squares.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActivityHeaderText(
                    text: AppLocalizations.of(context)!.informations),
                InformationBlocSquares(resultPlaceModel: resultPlaceModel),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActivityHeaderText(
                      text: AppLocalizations.of(context)!.wantThisPlace),
                  getYesNoButtons(context)
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Row getYesNoButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ActionButton(
                onTap: () => acceptPlace(context),
                title: AppLocalizations.of(context)!.yes)),
        const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
        Expanded(
            child: ActionButton(
                onTap: () => refusePlace(context),
                title: AppLocalizations.of(context)!.no))
      ],
    );
  }

  refusePlace(BuildContext context) {
        Navigator.of(context).popUntil((route) => route.isFirst);
  }

  acceptPlace(BuildContext context) async {
    var res = await BaseAPI.acceptPlace(resultPlaceModel.id);

    if (res.statusCode == 200) {
      ToastService.showSuccess(AppLocalizations.of(context)!.placeAddedHistory);

      await proceedInAppReview();

      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } else {
      ToastService.showError(AppLocalizations.of(context)!.internalError);
    }
  }

  proceedInAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
}
