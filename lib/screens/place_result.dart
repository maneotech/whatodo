import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:whatodo/components/information_bloc.dart';

import '../constants/constant.dart';
import '../models/result_place.dart';
import '../services/activity.dart';
import '../utils/map_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaceResultScreen extends StatefulWidget {
  final ResultPlaceModel resultPlaceModel;

  const PlaceResultScreen({
    super.key,
    required this.resultPlaceModel,
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
            if (widget.resultPlaceModel.urlPictureReference != null)
              Image.network(
                widget.resultPlaceModel.urlPictureReference!,
                height: 220,
              ),
            SizedBox(
              height: 130,
              child: getGoogleMap(),
            ),
            InformationBloc(
                resultPlaceModel: widget.resultPlaceModel,
                ),
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
          if (widget.resultPlaceModel.rating != null)
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
                    "${widget.resultPlaceModel.userRatingsTotals.toString()} ${AppLocalizations.of(context)!.reviews}",
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
