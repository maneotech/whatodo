import 'package:flutter/material.dart';
import 'package:whatodo/components/activity_header_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/action_button.dart';
import '../components/activity_container.dart';
import '../constants/constant.dart';

class PlaceResultScreen extends StatefulWidget {
  const PlaceResultScreen({super.key});

  @override
  State<PlaceResultScreen> createState() => _PlaceResultScreenState();
}

class _PlaceResultScreenState extends State<PlaceResultScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(43.529743, 5.447427);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          getTitleBox(),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  child: getGoogleMap(),
                ),
                Container(
                  child: getInformationBox(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox getTitleBox() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(""),
        const Text("Promenade de la torse",
            style: Constants.timeNumbersTextStyle),
        Row(
          children: const [
            Text("5"),
            Icon(Icons.star),
          ],
        ),
      ]),
    );
  }

  GoogleMap getGoogleMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 17.0,
      ),
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
              children: const [
                ActivityContainer(
                  title: "5 minutes à pied",
                  color: Constants.primaryColor,
                  iconPath: Constants.walkIcon,
                  onTap: null,
                  isActive: true,
                ),
                ActivityContainer(
                    title: "Gratuit",
                    color: Constants.thirdColor,
                    iconPath: Constants.freeIcon,
                    isActive: true,
                    onTap: null),
                ActivityContainer(
                    title: "Ouverture : de 8h à 15h",
                    color: Constants.secondaryColor,
                    iconPath: Constants.timeIcon,
                    isActive: true,
                    onTap: null),
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
}
