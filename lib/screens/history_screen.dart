import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatodo/components/history_bloc.dart';
import 'package:whatodo/constants/constant.dart';
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

  List<ResultPlaceModel> _acceptedPlaces = [];
  List<ResultPlaceModel> _allPlaces = [];

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    List<ResultPlaceModel> allPlaces = await getAllPlaces();

    setState(() {
      _allPlaces = allPlaces;
      _allPlaces.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      _acceptedPlaces =
          allPlaces.where((element) => element.accepted == true).toList();

      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Text(
                  AppLocalizations.of(context)!.acceptedPlaces,
                  style: Constants.activityHeaderTextStyle,
                ),
              ),
              Tab(
                child: Text(
                  AppLocalizations.of(context)!.suggestedPlaces,
                  style: Constants.activityHeaderTextStyle,
                ),
              ),
            ],
          ),
          loaded
              ? Expanded(
                  child: TabBarView(
                    children: [
                      // First tab content goes here
                      getContent(_acceptedPlaces, true),
                      // Second tab content goes here
                      getContent(_allPlaces, false)
                    ],
                  ),
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }

  /*SingleChildScrollView getAllPlacesScreen() {
    return SingleChildScrollView(
      child: StreamBuilder<List<ResultPlaceModel>>(
        stream: _dataStreamAllController.stream,
        builder: (context, snapshot) {
          return getContent(snapshot);
        },
      ),
    );
  }*/

  /*Widget getContent(AsyncSnapshot<List<ResultPlaceModel>> snapshot) {
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
  }*/

  Widget getContent(List<ResultPlaceModel> datas, bool isDeleteIcon) {
    if (datas.isEmpty) {
      return Text(AppLocalizations.of(context)!.noHistory);
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getInformationBlocs(datas, isDeleteIcon),
        ),
      );
    }
  }
  // By default, show a loading spinner
  //return const CircularProgressIndicator();

  Future<List<ResultPlaceModel>> getAllPlaces() async {
    final response = await BaseAPI.getAllPlaces();
    if (response.statusCode == 200) {
      List<dynamic> jsonAllPlaces = jsonDecode(response.body);
      List<ResultPlaceModel> allPlaces = jsonAllPlaces
          .map((json) => ResultPlaceModel.fromReqBody(jsonEncode(json)))
          .toList();

      allPlaces.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return allPlaces;
    } else {
      return ToastService.showError(
          AppLocalizations.of(context)!.internalError);
    }
  }

  List<HistoryBloc> getInformationBlocs(
      List<ResultPlaceModel> previousPlaces, bool isDeleteIcon) {
    List<HistoryBloc> previousPlacesBlocs = [];

    
    for (var previousPlace in previousPlaces) {
      bool? isNullableDeleteIcon = isDeleteIcon;
      if (isDeleteIcon == false && _acceptedPlaces.where((e) => e.id == previousPlace.id).isNotEmpty){
        isNullableDeleteIcon = null;
      }

      HistoryBloc informationBloc = HistoryBloc(
        resultPlaceModel: previousPlace,
        isDeleteIcon: isNullableDeleteIcon,
        onClickIcon: () => getIconClickEvent(isDeleteIcon, previousPlace)
      );

      previousPlacesBlocs.add(informationBloc);
    }

    return previousPlacesBlocs;
  }
  

  getIconClickEvent(bool? isDeleteIcon, ResultPlaceModel previousPlace){
    if (isDeleteIcon == null){
      return null;
    }

    return isDeleteIcon == true
            ? deleteActivityAlert(previousPlace)
            : acceptActivityAlert(previousPlace);
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

  acceptActivityAlert(ResultPlaceModel resultPlaceModel) {
    AlertService.showAlertDialogTwoButtons(
      context,
      AppLocalizations.of(context)!.yes,
      AppLocalizations.of(context)!.no,
      AppLocalizations.of(context)!.acceptActivityTitle,
      AppLocalizations.of(context)!.acceptActivityDesc,
      () => acceptActivity(resultPlaceModel.id),
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

  acceptActivity(String docId) async {
    final res = await BaseAPI.acceptPlace(docId);
    if (res.statusCode == 200) {
      addActivity(docId);
    } else {
      ToastService.showError(AppLocalizations.of(context)!.internalError);
    }
    //todo api request and pop from the array
  }

  addActivity(String docId) {
    try {
      var activity = _allPlaces.firstWhere((element) => element.id == docId);
      setState(() {
        _acceptedPlaces.add(activity);
        _acceptedPlaces.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      });
    } catch (e) {
      ToastService.showError(AppLocalizations.of(context)!.internalError);
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  removeActivity(String docId) {
    setState(() {
      _acceptedPlaces.removeWhere((element) => element.id == docId);
    });
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  dismissDialog() {
    Navigator.pop(context);
  }
}
