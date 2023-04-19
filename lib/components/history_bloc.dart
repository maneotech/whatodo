import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/constant.dart';
import '../models/result_place.dart';
import '../providers/locale.dart';
import 'activity_header_text.dart';
import 'information_bloc_squares.dart';

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
          padding: const EdgeInsets.only(top: 5.0, bottom: 30.0),
          child: Container(
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
                        child: ActivityHeaderText(text: resultPlaceModel.name),
                      ),
                      Column()
                    ],
                  ),
                  Text(
                    resultPlaceModel.address,
                    style: Constants.normalBlackTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: InformationBlocSquares(
                      resultPlaceModel: resultPlaceModel,
                    ),
                  ),
                  getDateText(context)
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

  Text getDateText(BuildContext context) {
    String locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;

    String formattedDate = DateFormat('EEEE - dd MMMM yyyy - HH:mm', locale)
        .format(resultPlaceModel.updatedAt);

    return Text(formattedDate, style: Constants.normalBlackTextStyle);
  }
}
