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

  final LatLng _pin = const LatLng(43.4925947, 5.3544352);

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyles);
    mapController = controller;
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
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Image.asset(
            Constants.loginImage,
            width: 20,
          ),
        )),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(widget.resultPlaceModel.name,
                style: Constants.titlePlaceTextStyle),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text("5"),
                  Icon(Icons.star),
                ],
              ),
              Text("${widget.resultPlaceModel.rating.toString()} avis",
                  style: Constants.rankingNumberTextStyle)
            ],
          ),
        ),
      ]),
    );
  }

  GoogleMap getGoogleMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _pin,
        zoom: 17.0,
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
