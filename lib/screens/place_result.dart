import 'package:flutter/material.dart';
import 'package:whatodo/components/activity_header_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whatodo/components/information_bloc.dart';
import 'package:whatodo/utils/enum_filters.dart';

import '../components/action_button.dart';
import '../components/activity_container.dart';
import '../constants/constant.dart';
import '../models/result_place.dart';
import '../services/activity.dart';
import '../utils/map_style.dart';

class PlaceResultScreen extends StatefulWidget {
  final ResultPlaceModel resultPlaceModel;

  const PlaceResultScreen({super.key, required this.resultPlaceModel});

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
    // TODO: implement initState
    super.initState();
    _pin = LatLng(
        widget.resultPlaceModel.latitude, widget.resultPlaceModel.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          getTitleBox(),
          Expanded(child: getGoogleMap()),
          InformationBloc(resultPlaceModel: widget.resultPlaceModel),
        ],
      ),
    );
  }

  SizedBox getTitleBox() {
    return SizedBox(
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(widget.resultPlaceModel.rating.toString()),
            const Icon(Icons.star),
          ],
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(widget.resultPlaceModel.name,
                style: Constants.titlePlaceTextStyle),
          ),
        ),
        Text("${widget.resultPlaceModel.userRatingsTotals.toString()} avis",
            style: Constants.rankingNumberTextStyle),
      ]),
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
