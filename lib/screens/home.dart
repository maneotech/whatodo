import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/components/activity_container.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:whatodo/models/request_place.dart';
import 'package:whatodo/providers/location.dart';
import 'package:whatodo/repositories/shared_pref.dart';
import 'package:whatodo/screens/opening.dart';
import 'package:whatodo/screens/place_result.dart';
import 'package:whatodo/services/toast.dart';

import '../components/action_button.dart';
import '../components/activity_header_text.dart';
import '../components/input_container.dart';
import '../providers/auth.dart';
import '../services/activity.dart';
import '../services/base_api.dart';
import '../utils/enum_filters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controllerHours = TextEditingController(text: "0");
  TextEditingController controllerMinutes = TextEditingController(text: "15");
  TextEditingController controllerAddress =
      TextEditingController(text: "Je saisi mon adresse ici");

  List<ActivityContainer> activityBlocs = [];
  List<ActivityContainer> priceBlocs = [];
  List<ActivityContainer> movingBlocs = [];

  List<ActivityType> selectedActivities = [];
  List<PriceType> selectedPrices = [];
  List<MovingType> selectedMovingTypes = [];

  @override
  void initState() {
    setActivityBlocs();
    setPriceBlocs();
    setMovingBlocs();
    super.initState();
  }

  setActivityBlocs() {
    activityBlocs = [
      ActivityService.getCulturelBloc(
        () => onTapActivity(ActivityType.culturel),
      ),
      ActivityService.getSportBloc(
        () => onTapActivity(ActivityType.sport),
      ),
      ActivityService.getRestaurantBloc(
        () => onTapActivity(ActivityType.restaurant),
      ),
      ActivityService.getBarBloc(
        () => onTapActivity(ActivityType.bar),
      ),
      ActivityService.getShoppingBloc(
        () => onTapActivity(ActivityType.shopping),
      ),
      ActivityService.getGroceryBloc(
        () => onTapActivity(ActivityType.grocery),
      ),
    ];
  }

  setPriceBlocs() {
    priceBlocs = [
      ActivityContainer(
          title: "Gratuit",
          color: Constants.primaryColor,
          iconPath: Constants.freeIcon,
          onTap: () => onTapPurchase(PriceType.free)),
      ActivityContainer(
          title: "Payant",
          color: Constants.secondaryColor,
          iconPath: Constants.notFreeIcon,
          onTap: () => onTapPurchase(PriceType.notFree)),
    ];
  }

  setMovingBlocs() {
    movingBlocs = [
      ActivityContainer(
          title: "En voiture",
          color: Constants.thirdColor,
          iconPath: Constants.carIcon,
          onTap: () => onTapMoving(MovingType.byCar)),
      ActivityContainer(
          title: "A vélo",
          color: Constants.secondaryColor,
          iconPath: Constants.bicycleIcon,
          onTap: () => onTapMoving(MovingType.byBicycle)),
      ActivityContainer(
          title: "A pied",
          color: Constants.primaryColor,
          iconPath: Constants.walkIcon,
          onTap: () => onTapMoving(MovingType.byWalk)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextButton(
          child: Text("Se déconnecter"),
          onPressed: () => disconnect(),
        ),
        Text("Hello John! Enjoy your"),
        Text("new adventure"),
        const ActivityHeaderText(text: "Activités"),
        GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: activityBlocs),
        const ActivityHeaderText(text: "Tarif"),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: priceBlocs,
        ),
        const ActivityHeaderText(text: "Moyen de se déplacer"),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: movingBlocs,
        ),
        const ActivityHeaderText(text: "Durée de déplacement"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputContainer(
                title: "Heure",
                color: Constants.secondaryColor,
                textController: controllerHours,
                type: InputContainerType.number,
                width: 80),
            getSeparator(":"),
            InputContainer(
                title: "Minutes",
                color: Constants.thirdColor,
                textController: controllerMinutes,
                type: InputContainerType.number,
                width: 80),
          ],
        ),
        const ActivityHeaderText(text: "Localisation"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: InputContainer(
                  title: "Ma position actuelle",
                  color: Constants.thirdColor,
                  textController: controllerAddress,
                  type: InputContainerType.address,
                  width: null),
            ),
            getSeparator("OU"),
            GestureDetector(
              onTap: () => getLocation(),
              child: const InputContainer(
                  title: "Cliquer ici",
                  color: Constants.primaryColor,
                  textController: null,
                  type: InputContainerType.icon,
                  width: 80),
            ),
          ],
        ),
        ActionButton(onTap: () => goToOpening(), title: "C'est parti!")
      ]),
    );
  }

  Column getSeparator(String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: Constants.heightContainer,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Center(
              child: Text(
                text,
                style: Constants.normalBlackTextStyle,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text("", style: Constants.normalBlackTextStyle),
        )
      ],
    );
  }

  getLocation() async {
    LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    bool getPosition = await locationProvider.getCurrentPosition();

    if (getPosition) {
      controllerAddress.text = locationProvider.currentAddress!;
    } else {
      //toast
    }
  }

  onTapActivity(ActivityType activity) {
    if (selectedActivities.contains(activity)) {
      selectedActivities.remove(activity);
    } else {
      selectedActivities.add(activity);
    }
  }

  onTapPurchase(PriceType PriceType) {
    if (selectedPrices.contains(PriceType)) {
      selectedPrices.remove(PriceType);
    } else {
      selectedPrices.add(PriceType);
    }
  }

  onTapMoving(MovingType movingType) {
    if (selectedMovingTypes.contains(movingType)) {
      selectedMovingTypes.remove(movingType);
    } else {
      selectedMovingTypes.add(movingType);
    }
  }

  goToOpening() async {
    if (checkAtLeastOneActivity() && checkPrice() && checkTime()) {
      LatLng latLng = LatLng(
        Provider.of<LocationProvider>(context, listen: false).lat!,
        Provider.of<LocationProvider>(context, listen: false).lng!,
      );

      String currentAddress =
          Provider.of<LocationProvider>(context, listen: false).currentAddress!;

      RequestPlace requestPlace = RequestPlace(
          selectedActivities,
          selectedPrices,
          selectedMovingTypes,
          latLng,
          currentAddress,
          int.parse(controllerHours.text),
          int.parse(controllerMinutes.text));

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OpeningScreen(requestPlace: requestPlace)),
        );
      }
    }
  }

  bool checkAtLeastOneActivity() {
    if (selectedActivities.isEmpty) {
      ToastService.showError("Veuillez choisir au moins une activité");

      return false;
    }

    return true;
  }

  bool checkPrice() {
    if (selectedPrices.isEmpty) {
      ToastService.showError(
          "Veuillez choisir si vous souhaitez une activité gratuite, payante ou les deux");

      return false;
    }

    return true;
  }

  bool checkTime() {
    if ((controllerHours.text == "0" || controllerHours.text == "00") &&
        (controllerMinutes.text == "0" || controllerMinutes.text == "00")) {
      ToastService.showError(
          "Veuillez indiquer un temps minimal pour le trajet souhaité");
      return false;
    }

    return true;
  }

  disconnect() async {
    await Provider.of<AuthProvider>(context, listen: false).logout();
  }
}
