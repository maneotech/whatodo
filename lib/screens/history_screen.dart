import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatodo/components/history_bloc.dart';
import 'package:whatodo/models/result_place.dart';
import 'package:whatodo/services/alert.dart';
import 'package:whatodo/services/base_api.dart';
import 'package:whatodo/services/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            return Text(AppLocalizations.of(context)!.noHistory);
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getInformationBlocs(resultPlaces),
            );
          }
        } else if (snapshot.hasError) {
          return Text(AppLocalizations.of(context)!.internalError);
        }
        // By default, show a loading spinner
        return const CircularProgressIndicator();
      },
    ));
  }

  Future<List<ResultPlaceModel>> getPreviousPlaces() async {
    final response = await BaseAPI.getAcceptedPlaces();
    if (response.statusCode == 200) {
      List<dynamic> jsonAcceptedPlaces = jsonDecode(response.body);
      List<ResultPlaceModel> acceptedPlaces = jsonAcceptedPlaces
          .map((json) => ResultPlaceModel.fromReqBody(jsonEncode(json)))
          .toList();

      acceptedPlaces.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return acceptedPlaces;
    } else {
      throw Exception();
    }
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
    AlertService.showAlertDialogTwoButtons(
      context,
      AppLocalizations.of(context)!.yes,
      AppLocalizations.of(context)!.no,
      AppLocalizations.of(context)!.deleteActivityTitle,
      AppLocalizations.of(context)!.deleteActivityDesc,
      () => deleteActivity(resultPlaceModel.id),
      () => dismissDialog(),
    );
  }

  deleteActivity(String docId) async {
    final res = await BaseAPI.refusePlace(docId);

    if (res.statusCode == 200) {
      removeActivity(docId);
    } else {
      ToastService.showError(AppLocalizations.of(context)!.internalError);
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
