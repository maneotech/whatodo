import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/components/activity_container.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:whatodo/models/home_response.dart';
import 'package:whatodo/models/request_place.dart';
import 'package:whatodo/providers/location.dart';
import 'package:whatodo/screens/duration_picker.dart';
import 'package:whatodo/screens/helper_.dart';
import 'package:whatodo/screens/opening.dart';
import 'package:whatodo/screens/purchase_screen.dart';
import 'package:whatodo/screens/require_location_info.dart';
import 'package:whatodo/services/alert.dart';
import 'package:whatodo/services/toast.dart';

import '../components/action_button.dart';
import '../components/activity_header_text.dart';
import '../components/input_container.dart';
import '../providers/user.dart';
import '../services/base_api.dart';
import '../services/utils.dart';
import '../utils/enum_filters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //TextEditingController controllerHours = TextEditingController(text: "0");
  //TextEditingController controllerMinutes = TextEditingController(text: "15");

  int maxMin = 15;

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

    //addPostFrameCallback fix LocationProvider crash issue
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setActivityBlocs(false);
      //setPriceBlocs();
      setMovingBlocs();
      getHome();

      Provider.of<LocationProvider>(context, listen: false)
          .getLocationFromDisk();
    });
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "${AppLocalizations.of(context)!.hello} ${Provider.of<UserProvider>(context).firstname} ! ${AppLocalizations.of(context)!.enjoyYour}"),
          Row(
            children: [
              Text(AppLocalizations.of(context)!.enjoyYour2),
              Text(
                " ${AppLocalizations.of(context)!.adventure}",
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Constants.secondaryColor),
              ),
            ],
          ),
          getTitleSectionRow(
              AppLocalizations.of(context)!.activities, selectedActivities, 5),
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
          getTitleSectionRow(
              AppLocalizations.of(context)!.movingType, selectedMovingTypes, 3),
          SizedBox(
            height: 75,
            child: Row(
              children: movingBlocs,
            ),
          ),
          Padding(
            padding: Constants.paddingActivityTitle,
            child: ActivityHeaderText(
                text: AppLocalizations.of(context)!.movingTime),
          ),
          SizedBox(
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ActivityContainer(
                    title:
                        "< ${maxMin.toString()} ${AppLocalizations.of(context)!.minutes}",
                    color: Constants.secondaryColor,
                    iconPath: Constants.timeIcon,
                    onTap: () => showDurationPicker(),
                    changeColorOnTap: false,
                    isActive: false),
              ],
            ),
          ),
          Padding(
            padding: Constants.paddingActivityTitle,
            child: ActivityHeaderText(
                text: AppLocalizations.of(context)!.location),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InputContainer(
                    title: AppLocalizations.of(context)!.currentLocation,
                    color: Constants.thirdColor,
                    textController: controllerAddress,
                    type: InputContainerType.address,
                    width: null),
              ),
              getSeparator(AppLocalizations.of(context)!.or),
              GestureDetector(
                onTap: () => getLocation(),
                child: InputContainer(
                    title: AppLocalizations.of(context)!.clickHere,
                    color: Constants.primaryColor,
                    textController: null,
                    type: InputContainerType.icon,
                    width: 80),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: ActionButton(
                onTap: () => goToOpening(),
                title: AppLocalizations.of(context)!.letsGo),
          ),
        ],
      ),
    );
  }

  showDurationPicker() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => DurationPisckerScreen(
          selectDuration: updateDuration,
        ),
      ),
    );
  }

  updateDuration(int minutes) {
    setState(() {
      maxMin = minutes;
    });
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
        .setGetHomeResponse(homeModel.enableAdVideo, homeModel.user);

    if (homeModel.lastSponsorshipEmail != null &&
        homeModel.lastSponsorshipEmail!.isNotEmpty &&
        mounted) {
      AlertService.showAlertDialogOneButton(
          context,
          AppLocalizations.of(context)!.nice,
          AppLocalizations.of(context)!.bravo,
          "${AppLocalizations.of(context)!.user} ${homeModel.lastSponsorshipEmail} ${AppLocalizations.of(context)!.earnRegisteredToken}",
          () => Navigator.of(context).pop());

      await BaseAPI.sponsorshipHasBeenNotified(homeModel.lastSponsorshipEmail!);
    }

    //check for first openapp

    bool isFirstOpening = await UtilService.isFirstOpenApp();
    if (mounted && isFirstOpening) {
      showDialog(
        context: context,
        builder: (BuildContext bc) {
          return const HelperScreen();
        },
      );
    }
  }

  setActivityBlocs(bool isActive) {
    activityBlocs1 = [
      ActivityContainer(
        title: AppLocalizations.of(context)!.snacking,
        color: Constants.primaryColor,
        iconPath: Constants.snackingIcon,
        isActive: isActive,
        changeColorOnTap: true,
        onTap: () => onTapActivity(ActivityType.snacking),
      ),
      ActivityContainer(
        title: AppLocalizations.of(context)!.bar,
        color: Constants.secondaryColor,
        iconPath: Constants.barIcon,
        isActive: isActive,
        changeColorOnTap: true,
        onTap: () => onTapActivity(ActivityType.bar),
      ),
      ActivityContainer(
        title: AppLocalizations.of(context)!.restaurant,
        color: Constants.thirdColor,
        iconPath: Constants.restaurantIcon,
        isActive: isActive,
        changeColorOnTap: true,
        onTap: () => onTapActivity(ActivityType.restaurant),
      )
    ];

    activityBlocs2 = [
      ActivityContainer(
          title: AppLocalizations.of(context)!.discovering,
          color: Constants.thirdColor,
          iconPath: Constants.discoveringIcon,
          isActive: isActive,
          changeColorOnTap: true,
          onTap: () => onTapActivity(ActivityType.discovering)),
      ActivityContainer(
        title: AppLocalizations.of(context)!.shopping,
        color: Constants.secondaryColor,
        iconPath: Constants.shoppingIcon,
        isActive: isActive,
        changeColorOnTap: true,
        onTap: () => onTapActivity(ActivityType.shopping),
      ),
      ActivityContainer(
          title: AppLocalizations.of(context)!.random,
          color: Constants.primaryColor,
          iconPath: Constants.randomIcon,
          onTap: () => onTapActivity(ActivityType.random),
          changeColorOnTap: false,
          isActive: false)
    ];
  }

  setMovingBlocs() {
    movingBlocs = [
      ActivityContainer(
          title: AppLocalizations.of(context)!.byWalk,
          color: Constants.primaryColor,
          iconPath: Constants.walkIcon,
          changeColorOnTap: true,
          onTap: () => onTapMoving(MovingType.byWalk)),
      ActivityContainer(
          title: AppLocalizations.of(context)!.byBicycle,
          color: Constants.secondaryColor,
          iconPath: Constants.bicycleIcon,
          changeColorOnTap: true,
          onTap: () => onTapMoving(MovingType.byBicycle)),
      ActivityContainer(
          title: AppLocalizations.of(context)!.byCar,
          color: Constants.thirdColor,
          iconPath: Constants.carIcon,
          changeColorOnTap: true,
          onTap: () => onTapMoving(MovingType.byCar)),
    ];
  }

  Padding getTitleSectionRow(String title, List list, int numberMax) {
    String selectedText = list.length < 2
        ? AppLocalizations.of(context)!.selected
        : AppLocalizations.of(context)!.selecteds;

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
      children: const [
        SizedBox(
          height: Constants.heightContainer,
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            /*child: Center(
              child: Text(
                text,
                style: Constants.normalBlackTextStyle,
              ),
            ),*/
          ),
        ),
        Padding(
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
    if (Provider.of<UserProvider>(context, listen: false).token > 0) {
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
          0,
          maxMin,
        );

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OpeningScreen(requestPlace: requestPlace),
            ),
          );
        }
      }
    } else {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PurchaseScreen()),
        );
      }
    }
  }

  bool checkAtLeastOneActivity() {
    if (selectedActivities.isEmpty) {
      ToastService.showError(AppLocalizations.of(context)!.selectOneActivity);

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
      ToastService.showError(AppLocalizations.of(context)!.selectOneMoving);
      return false;
    }
    return true;
  }

  bool checkTime() {
    if (maxMin.toString() == "0") {
      ToastService.showError(AppLocalizations.of(context)!.selectTime);
      return false;
    }

    return true;
  }

  bool checkLat(double? lat, double? lng) {
    if ((lat == null || lng == null)) {
      ToastService.showError(AppLocalizations.of(context)!.selectPosition);
      return false;
    } else {
      return true;
    }
  }
}
