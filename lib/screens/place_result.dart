import 'package:flutter/material.dart';
import 'package:whatodo/components/activity_header_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
          getInformationBox(),
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

  Padding getInformationBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0, right: 7.0, bottom: 30.0),
      child: Container(
        height: 280,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              children: const [ActivityHeaderText(text: "Informations")],
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: [
                ActivityContainer(
                  title:
                      "${widget.resultPlaceModel.travellingDuration.toString()} minutes à pied",
                  color: Constants.primaryColor,
                  iconPath: Constants.walkIcon,
                  onTap: null,
                  isActive: true,
                ),
                ActivityContainer(
                    title:
                        widget.resultPlaceModel.isFree ? "Gratuit" : "Payant",
                    color: Constants.thirdColor,
                    iconPath: widget.resultPlaceModel.isFree
                        ? Constants.freeIcon
                        : Constants.notFreeIcon,
                    isActive: true,
                    onTap: null),
                getActivityContainer(),
              ],
            ),
            Row(
              children: [
                Expanded(child: ActionButton(onTap: () => null, title: "Oui")),
                const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                Expanded(child: ActionButton(onTap: () => null, title: "Non"))
              ],
            )
          ]),
        ),
      ),
    );
  }

  ActivityContainer getActivityContainer() {
    switch (widget.resultPlaceModel.activityType) {
      case ActivityType.culturel:
        return ActivityService.getCulturelBloc(null);

      case ActivityType.bar:
        return ActivityService.getBarBloc(null);

      case ActivityType.restaurant:
        return ActivityService.getRestaurantBloc(null);

      case ActivityType.sport:
        return ActivityService.getSportBloc(null);

      case ActivityType.shopping:
        return ActivityService.getShoppingBloc(null);

      case ActivityType.grocery:
        return ActivityService.getGroceryBloc(null);

      default:
        return ActivityService.getCulturelBloc(null);
    }
  }
}
