import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/components/activity_container.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:whatodo/models/home_response.dart';
import 'package:whatodo/models/request_place.dart';
import 'package:whatodo/providers/location.dart';
import 'package:whatodo/screens/opening.dart';
import 'package:whatodo/screens/require_location_info.dart';
import 'package:whatodo/services/alert.dart';
import 'package:whatodo/services/toast.dart';

import '../components/action_button.dart';
import '../components/activity_header_text.dart';
import '../components/input_container.dart';
import '../providers/user.dart';
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
      TextEditingController(text: "Aucune adresse");

  List<ActivityContainer> activityBlocs1 = [];
  List<ActivityContainer> activityBlocs2 = [];

  List<ActivityContainer> priceBlocs = [];
  List<ActivityContainer> movingBlocs = [];

  List<ActivityType> selectedActivities = [];
  //List<PriceType> selectedPrices = [];
  List<MovingType> selectedMovingTypes = [];

  @override
  void initState() {
    super.initState();
    setActivityBlocs(false);
    //setPriceBlocs();
    setMovingBlocs();
    getHome();

    Provider.of<LocationProvider>(context, listen: false).getLocationFromDisk();
  }

  @override
  void didChangeDependencies() {
    controllerAddress.text = Provider.of<LocationProvider>(
      context,
      listen: true, // Be sure to listen
    ).currentAddress;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
            "Hello ${Provider.of<UserProvider>(context).firstname} ! Enjoy your"),
        Row(
          children: const [
            Text("new "),
            Text(
              "adventure",
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: Constants.secondaryColor),
            ),
          ],
        ),
        getTitleSectionRow("Activités", selectedActivities, 5),
        SizedBox(
          height: 75,
          child: Row(
            children: activityBlocs1,
          ),
        ),
        SizedBox(
          height: 75,
          child: Row(
            children: activityBlocs2,
          ),
        ),
        /*getTitleSectionRow("Tarif", selectedPrices, 2),
        SizedBox(
          height: 75,
          child: Row(
            children: priceBlocs,
          ),
        ),*/
        getTitleSectionRow("Moyen de se déplacer", selectedMovingTypes, 3),
        SizedBox(
          height: 75,
          child: Row(
            children: movingBlocs,
          ),
        ),
        const Padding(
          padding: Constants.paddingActivityTitle,
          child: ActivityHeaderText(text: "Durée de déplacement"),
        ),
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
        const Padding(
          padding: Constants.paddingActivityTitle,
          child: ActivityHeaderText(text: "Localisation"),
        ),
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

  getHome() async {
    var homeResponse = await BaseAPI.getHome();
    if (homeResponse.statusCode == 200 && mounted) {
      var homeModel = HomeResponse.fromReqBody(homeResponse.body);
      checkForHomeInfos(homeModel);
    }
  }

  checkForHomeInfos(HomeResponse homeModel) async {
    await Provider.of<UserProvider>(context, listen: false)
        .setGetHomeResponse(homeModel.enableAdVideo, homeModel.token);
        

    if (homeModel.lastSponsorshipEmail != null &&
        homeModel.lastSponsorshipEmail!.isNotEmpty &&
        mounted) {
      AlertService.showAlertDialogOneButton(
          context,
          "Super!",
          "Bravo!",
          "L'utilisateur ${homeModel.lastSponsorshipEmail} s'est bien inscrit, tu gagnes 1 token!",
          () => Navigator.of(context).pop());

      await BaseAPI.sponsorshipHasBeenNotified(homeModel.lastSponsorshipEmail!);
    }
  }

  setActivityBlocs(bool isActive) {
    activityBlocs1 = [
      ActivityService.getSnackingBloc(
          () => onTapActivity(ActivityType.snacking), isActive,
          changeColorOnTap: true),
      ActivityService.getBarBloc(
          () => onTapActivity(ActivityType.bar), isActive,
          changeColorOnTap: true),
      ActivityService.getRestaurantBloc(
          () => onTapActivity(ActivityType.restaurant), isActive,
          changeColorOnTap: true),
    ];

    activityBlocs2 = [
      ActivityService.getDiscoveringBloc(
          () => onTapActivity(ActivityType.discovering), isActive,
          changeColorOnTap: true),
      ActivityService.getShoppingBloc(
          () => onTapActivity(ActivityType.shopping), isActive,
          changeColorOnTap: true),
      ActivityService.getRandomBloc(
          () => onTapActivity(ActivityType.random), false,
          changeColorOnTap: false),
    ];
  }

  /*setPriceBlocs() {
    priceBlocs = [
      ActivityContainer(
          title: "Gratuit",
          color: Constants.primaryColor,
          iconPath: Constants.freeIcon,
          changeColorOnTap: true,
          onTap: () => onTapPurchase(PriceType.free)),
      ActivityContainer(
          title: "Payant",
          color: Constants.secondaryColor,
          iconPath: Constants.notFreeIcon,
          changeColorOnTap: true,
          onTap: () => onTapPurchase(PriceType.notFree)),
    ];
  }*/

  setMovingBlocs() {
    movingBlocs = [
      ActivityContainer(
          title: "A pied",
          color: Constants.primaryColor,
          iconPath: Constants.walkIcon,
          changeColorOnTap: true,
          onTap: () => onTapMoving(MovingType.byWalk)),
      ActivityContainer(
          title: "A vélo",
          color: Constants.secondaryColor,
          iconPath: Constants.bicycleIcon,
          changeColorOnTap: true,
          onTap: () => onTapMoving(MovingType.byBicycle)),
      ActivityContainer(
          title: "En voiture",
          color: Constants.thirdColor,
          iconPath: Constants.carIcon,
          changeColorOnTap: true,
          onTap: () => onTapMoving(MovingType.byCar)),
    ];
  }

  Padding getTitleSectionRow(String title, List list, int numberMax) {
    String selectedText = list.length < 2 ? "sélectionnée" : "sélectionnées";

    return Padding(
      padding: Constants.paddingActivityTitle,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActivityHeaderText(text: title),
            Text("${list.length}/$numberMax $selectedText",
                style: Constants.rankingNumberTextStyle)
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
      controllerAddress.text = locationProvider.currentAddress;
    } else {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const RequireLocationInfo(),
          ),
        );
      }
    }
  }

  onTapActivity(ActivityType activity) {
    setState(() {
      if (activity == ActivityType.random) {
        if (selectedActivities.length == 5) {
          selectedActivities.clear();

          setActivityBlocs(false);
        } else {
          selectedActivities.clear();
          selectedActivities.add(ActivityType.bar);
          selectedActivities.add(ActivityType.restaurant);
          selectedActivities.add(ActivityType.snacking);
          selectedActivities.add(ActivityType.shopping);
          selectedActivities.add(ActivityType.discovering);
          setActivityBlocs(true);
        }
      } else {
        if (selectedActivities.contains(activity)) {
          selectedActivities.remove(activity);
        } else {
          selectedActivities.add(activity);
        }
      }
    });
  }

  /*onTapPurchase(PriceType priceType) {
    setState(() {
      if (selectedPrices.contains(priceType)) {
        selectedPrices.remove(priceType);
      } else {
        selectedPrices.add(priceType);
      }
    });
  }*/

  onTapMoving(MovingType movingType) {
    setState(() {
      if (selectedMovingTypes.contains(movingType)) {
        selectedMovingTypes.remove(movingType);
      } else {
        selectedMovingTypes.add(movingType);
      }
    });
  }

  goToOpening() async {
    double? lat = Provider.of<LocationProvider>(context, listen: false).lat;
    double? lng = Provider.of<LocationProvider>(context, listen: false).lng;

    if (checkAtLeastOneActivity() &&
        /*checkPrice() &&*/
        checkMoving() &&
        checkTime() &&
        checkLat(lat, lng)) {
      /*  String currentAddress =
          Provider.of<LocationProvider>(context, listen: false).currentAddress!;*/

      RequestPlace requestPlace = RequestPlace(
        selectedActivities,
        //selectedPrices,
        selectedMovingTypes,
        lat!,
        lng!,
        int.parse(controllerHours.text),
        int.parse(controllerMinutes.text),
      );

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

  /*bool checkPrice() {
    if (selectedPrices.isEmpty) {
      ToastService.showError(
          "Veuillez choisir si vous souhaitez une activité gratuite, payante ou les deux");

      return false;
    }

    return true;
  }*/

  bool checkMoving() {
    if (selectedMovingTypes.isEmpty) {
      ToastService.showError(
          "Veuillez choisir au moins un moyen de transport souhaité");
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

  bool checkLat(double? lat, double? lng) {
    if ((lat == null || lng == null)) {
      ToastService.showError("Veuillez ajouter votre position");
      return false;
    } else {
      return true;
    }
  }
}
