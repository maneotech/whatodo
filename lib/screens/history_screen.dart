import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whatodo/components/history_bloc.dart';
import 'package:whatodo/components/information_bloc.dart';
import 'package:whatodo/models/result_place.dart';
import 'package:whatodo/screens/place_result.dart';
import 'package:whatodo/services/alert.dart';
import 'package:whatodo/utils/enum_filters.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ResultPlaceModel> previousPlaces = [];
  List<HistoryBloc> historyBlocs = [];

  @override
  void initState() {
    // TODO: implement initState
    getPreviousPlaces();
    getInformationBlocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: historyBlocs),
    );
  }

  getPreviousPlaces() {
    ResultPlaceModel resultPlaceModel = ResultPlaceModel(
        "ok",
        "Parc Jourdan",
        "345 rue X - Aix-en-Provence 13100, France",
        4.5,
        const LatLng(54, 54),
        [],
        "",
        [""],
        55200,
        ActivityType.sport,
        PriceType.free,
        MovingType.byBicycle,
        12);

    ResultPlaceModel resultPlaceModel2 = ResultPlaceModel(
        "ok",
        "Parc Jourdan",
        "345 rue X - Aix-en-Provence 13100, France",
        4.5,
        const LatLng(54, 54),
        [],
        "",
        [""],
        55200,
        ActivityType.sport,
        PriceType.free,
        MovingType.byBicycle,
        12);
    previousPlaces.add(resultPlaceModel);
    previousPlaces.add(resultPlaceModel2);
  }

  getInformationBlocs() {
    for (var previousPlace in previousPlaces) {
      HistoryBloc informationBloc = HistoryBloc(
        resultPlaceModel: previousPlace,
        onDeleteActivity: () => deleteActivityAlert(previousPlace),
      );

      setState(() {
        historyBlocs.add(informationBloc);
      });
    }
  }

  deleteActivityAlert(ResultPlaceModel resultPlaceModel) {
    print("ici");
    AlertService.showAlertDialogTwoButtons(
      context,
      "Oui",
      "Non",
      "Supprimer cette activité",
      "Êtes-vous sûr(e) de supprimer cette activité ?",
      () => deleteActivity(resultPlaceModel),
      () => dismissDialog(),
    );
  }

  deleteActivity(ResultPlaceModel resultPlaceModel) {
    //todo api request and pop from the array
  }

  dismissDialog(){
    Navigator.pop(context);
  }
}
