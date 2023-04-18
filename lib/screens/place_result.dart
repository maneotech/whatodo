import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whatodo/components/information_bloc.dart';

import '../constants/constant.dart';
import '../models/request_place.dart';
import '../models/result_place.dart';
import '../services/activity.dart';
import '../utils/map_style.dart';

class PlaceResultScreen extends StatefulWidget {
  final ResultPlaceModel resultPlaceModel;
  final RequestPlace requestPlaceModel;

  const PlaceResultScreen({
    super.key,
    required this.resultPlaceModel,
    required this.requestPlaceModel,
  });

  @override
  State<PlaceResultScreen> createState() => _PlaceResultScreenState();
}

class _PlaceResultScreenState extends State<PlaceResultScreen> {
  late GoogleMapController mapController;

  late LatLng _pin;

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyles);
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _pin = LatLng(
        widget.resultPlaceModel.latitude, widget.resultPlaceModel.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            getTitleBox(),
            Image.network(widget.resultPlaceModel.urlPictureReference),
            SizedBox(
              height: 200,
              child: getGoogleMap(),
            ),
            InformationBloc(resultPlaceModel: widget.resultPlaceModel, requestPlaceModel: widget.requestPlaceModel),
          ],
        ),
      ),
    );
  }

  Widget getTitleBox() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActivityService.fromActivityTypeToIconAsset(
              widget.resultPlaceModel.generatedOptions.activityType),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.resultPlaceModel.name,
                  style: Constants.titlePlaceTextStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.resultPlaceModel.address,
                  style: Constants.activityHeaderTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.resultPlaceModel.rating.toString()),
                  const Icon(Icons.star),
                ],
              ),
              Text(
                  "${widget.resultPlaceModel.userRatingsTotals.toString()} avis",
                  style: Constants.rankingNumberTextStyle),
            ],
          )
        ],
      ),
    );
  }

  GoogleMap getGoogleMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _pin,
        zoom: 16.0,
      ),
      markers: <Marker>{getMarker()},
      mapToolbarEnabled: false,
    );
  }

  Marker getMarker() {
    return Marker(
      markerId: const MarkerId('ChIJ5QKV1wrtyRIRnHlvG28H1nA'),
      position: _pin,
    );
  }
}
