import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/components/activity_container.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:whatodo/providers/location.dart';
import 'package:whatodo/repositories/shared_pref.dart';

import '../components/action_button.dart';
import '../components/activity_header_text.dart';
import '../components/input_container.dart';
import '../providers/auth.dart';
import '../services/base_api.dart';

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
            children: [
              ActivityContainer(
                title: "Culturel",
                color: Constants.primaryColor,
                iconPath: Constants.culturelIcon,
                onTap: () => onTapContainer(0),
              ),
              ActivityContainer(
                  title: "Sport",
                  color: Constants.secondaryColor,
                  iconPath: Constants.sportIcon,
                  onTap: () => onTapContainer(0)),
              ActivityContainer(
                  title: "Restaurant",
                  color: Constants.thirdColor,
                  iconPath: Constants.restaurantIcon,
                  onTap: () => onTapContainer(2)),
              ActivityContainer(
                  title: "Bar",
                  color: Constants.thirdColor,
                  iconPath: Constants.barIcon,
                  onTap: () => onTapContainer(3)),
              ActivityContainer(
                  title: "Shopping",
                  color: Constants.primaryColor,
                  iconPath: Constants.shoppingIcon,
                  onTap: () => onTapContainer(0)),
              ActivityContainer(
                  title: "Alimentation",
                  color: Constants.secondaryColor,
                  iconPath: Constants.groceryIcon,
                  onTap: () => onTapContainer(0))
            ]),
        const ActivityHeaderText(text: "Tarif"),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: [
            ActivityContainer(
                title: "Gratuit",
                color: Constants.primaryColor,
                iconPath: Constants.freeIcon,
                onTap: () => onTapContainer(0)),
            ActivityContainer(
                title: "Payant",
                color: Constants.secondaryColor,
                iconPath: Constants.notFreeIcon,
                onTap: () => onTapContainer(0)),
          ],
        ),
        const ActivityHeaderText(text: "Moyen de se déplacer"),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: [
            ActivityContainer(
                title: "En voiture",
                color: Constants.thirdColor,
                iconPath: Constants.carIcon,
                onTap: () => onTapContainer(0)),
            ActivityContainer(
                title: "A vélo",
                color: Constants.secondaryColor,
                iconPath: Constants.bicycleIcon,
                onTap: () => onTapContainer(0)),
            ActivityContainer(
                title: "A pied",
                color: Constants.primaryColor,
                iconPath: Constants.walkIcon,
                onTap: () => onTapContainer(0)),
          ],
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
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Text(
                ":",
                style: Constants.normalBlackTextStyle,
              ),
            ),
            InputContainer(
              title: "Minutes",
              color: Constants.thirdColor,
              textController: controllerMinutes,
              type: InputContainerType.number,
            ),
          ],
        ),
        const ActivityHeaderText(text: "Localisation"),
        Row(
          children: [
            InputContainer(
              title: "Ma position actuelle",
              color: Constants.thirdColor,
              textController: controllerAddress,
              type: InputContainerType.address,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Text(
                ":",
                style: Constants.normalBlackTextStyle,
              ),
            ),
            GestureDetector(
              onTap: () => getLocation(),
              child: const InputContainer(
                title: "Cliquer ici",
                color: Constants.primaryColor,
                textController: null,
                type: InputContainerType.icon,
              ),
            ),
          ],
        ),
        ActionButton(onTap: () => test(), title: "C'est parti!")
      ]),
    );
  }

  getLocation() async {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context, listen: false);
    bool getPosition = await locationProvider.getCurrentPosition();
    
    if (getPosition){

    }
    else {
      
    }

  }

  onTapContainer(int index) {}

  test() async {
    try {
      var res = await BaseAPI.nearbySearch();
      var body = res.body;
      print(res.body);
      print(res);
    } catch (e) {
      print(e);
    }
  }

  disconnect() async {
    await Provider.of<AuthProvider>(context, listen: false).logout();
  }
}
