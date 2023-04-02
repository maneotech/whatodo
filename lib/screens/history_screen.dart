import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whatodo/components/history_bloc.dart';
import 'package:whatodo/components/information_bloc.dart';
import 'package:whatodo/models/generated_options._place.dart';
import 'package:whatodo/models/result_place.dart';
import 'package:whatodo/screens/place_result.dart';
import 'package:whatodo/services/alert.dart';
import 'package:whatodo/services/base_api.dart';
import 'package:whatodo/services/toast.dart';
import 'package:whatodo/utils/enum_filters.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ResultPlaceModel> previousPlaces = [];
  List<HistoryBloc> historyBlocs = [];

  final StreamController<List<ResultPlaceModel>> _dataStreamController =
      StreamController<List<ResultPlaceModel>>.broadcast();

  List<ResultPlaceModel> _previousPlaces = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    _previousPlaces = await getPreviousPlaces();
    _dataStreamController.add(_previousPlaces);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: StreamBuilder<List<ResultPlaceModel>>(
      stream: _dataStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final resultPlaces = snapshot.data!;
          if (resultPlaces.isEmpty) {
            return const Text("Vous n'avez actuellement aucun historique");
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getInformationBlocs(resultPlaces),
            );
          }
        } else if (snapshot.hasError) {
          return const Text('Une erreur est survenue, merci de réessayer');
        }
        // By default, show a loading spinner
        return const CircularProgressIndicator();
      },
    ));
    /* return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: historyBlocs),
    );*/
  }

  Future<List<ResultPlaceModel>> getPreviousPlaces() async {
    final response = await BaseAPI.getAcceptedPlaces();
    if (response.statusCode == 200) {
      List<dynamic> jsonAcceptedPlaces = jsonDecode(response.body);
      List<ResultPlaceModel> acceptedPlaces = jsonAcceptedPlaces
          .map((json) => ResultPlaceModel.fromReqBody(jsonEncode(json)))
          .toList();

      return acceptedPlaces;
    } else {
      throw Exception();
    }

    /* for (var acceptedPlace in acceptedPlaces) {
              setState(() {
                previousPlaces.add(acceptedPlace);
              }); 
      }

    ResultPlaceModel resultPlaceModel = ResultPlaceModel(
        "qsd",
        "ok",
        "Parc Jourdan",
        "345 rue X - Aix-en-Provence 13100, France",
        4.5,
        54,
        54,
        [],
        300,
        GeneratedOptions(
            ActivityType.bar, MovingType.byBicycle, PriceType.free, 10));

    ResultPlaceModel resultPlaceModel2 = ResultPlaceModel(
        "sqd",
        "ok",
        "Parc Jourdan",
        "345 rue X - Aix-en-Provence 13100, France",
        4.5,
        54,
        54,
        [],
        300,
        GeneratedOptions(
            ActivityType.bar, MovingType.byBicycle, PriceType.free, 10));
    previousPlaces.add(resultPlaceModel);
    previousPlaces.add(resultPlaceModel2);*/
  }

  List<HistoryBloc> getInformationBlocs(List<ResultPlaceModel> previousPlaces) {
    List<HistoryBloc> previousPlacesBlocs = [];

    for (var previousPlace in previousPlaces) {
      HistoryBloc informationBloc = HistoryBloc(
        resultPlaceModel: previousPlace,
        onDeleteActivity: () => deleteActivityAlert(previousPlace),
      );

      previousPlacesBlocs.add(informationBloc);
    }

    return previousPlacesBlocs;
  }

  deleteActivityAlert(ResultPlaceModel resultPlaceModel) {
    print("ici");
    AlertService.showAlertDialogTwoButtons(
      context,
      "Oui",
      "Non",
      "Supprimer cette activité",
      "Êtes-vous sûr(e) de supprimer cette activité ?",
      () => deleteActivity(resultPlaceModel.id),
      () => dismissDialog(),
    );
  }

  deleteActivity(String docId) async {
    final res = await BaseAPI.refusePlace(docId);

    if (res.statusCode == 200) {
      removeActivity(docId);
    } else {
      ToastService.showError("Une erreur est survenue, merci de réessayer");
    }
    //todo api request and pop from the array
  }

  removeActivity(String docId) {
    _previousPlaces.removeWhere((element) => element.id == docId);
    _dataStreamController.add(_previousPlaces);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  dismissDialog() {
    Navigator.pop(context);
  }
}
