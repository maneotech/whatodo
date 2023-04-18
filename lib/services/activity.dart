import 'package:flutter/material.dart';
import 'package:whatodo/utils/enum_filters.dart';

import '../components/activity_container.dart';
import '../constants/constant.dart';

class ActivityService {
  static ActivityContainer getRandomBloc(Function? callback, bool isActive,
      {bool changeColorOnTap = false}) {
    return ActivityContainer(
        title: "Aléatoire",
        color: Constants.primaryColor,
        iconPath: Constants.randomIcon,
        onTap: callback != null ? () => callback() : null,
        changeColorOnTap: changeColorOnTap,
        isActive: isActive);
  }

  static ActivityContainer getDiscoveringBloc(Function? callback, bool isActive,
      {bool changeColorOnTap = false}) {
    return ActivityContainer(
      title: "Découvrir",
      color: Constants.thirdColor,
      iconPath: Constants.discoveringIcon,
      isActive: isActive,
      changeColorOnTap: changeColorOnTap,
      onTap: callback != null ? () => callback() : null,
    );
  }

  static ActivityContainer getRestaurantBloc(Function? callback, bool isActive,
      {bool changeColorOnTap = false}) {
    return ActivityContainer(
      title: "Restaurant",
      color: Constants.thirdColor,
      iconPath: Constants.restaurantIcon,
      isActive: isActive,
      changeColorOnTap: changeColorOnTap,
      onTap: callback != null ? () => callback() : null,
    );
  }

  static ActivityContainer getBarBloc(Function? callback, bool isActive,
      {bool changeColorOnTap = false}) {
    return ActivityContainer(
      title: "Bar",
      color: Constants.secondaryColor,
      iconPath: Constants.barIcon,
      isActive: isActive,
      changeColorOnTap: changeColorOnTap,
      onTap: callback != null ? () => callback() : null,
    );
  }

  static ActivityContainer getShoppingBloc(Function? callback, bool isActive,
      {bool changeColorOnTap = false}) {
    return ActivityContainer(
      title: "Shopping",
      color: Constants.secondaryColor,
      iconPath: Constants.shoppingIcon,
      isActive: isActive,
      changeColorOnTap: changeColorOnTap,
      onTap: callback != null ? () => callback() : null,
    );
  }

  static ActivityContainer getSnackingBloc(Function? callback, bool isActive,
      {bool changeColorOnTap = false}) {
    return ActivityContainer(
      title: "Petite faim",
      color: Constants.primaryColor,
      iconPath: Constants.snackingIcon,
      isActive: isActive,
      changeColorOnTap: changeColorOnTap,
      onTap: callback != null ? () => callback() : null,
    );
  }

static ActivityContainer getActivityContainer(ActivityType activityType) {
    var title = "Aléatoire";
    var iconPath = Constants.randomIcon;

    switch (activityType) {
      case ActivityType.random:
        title = "Aléatoire";
        iconPath = Constants.randomIcon;
        break;

      case ActivityType.bar:
        title = "Bar";
        iconPath = Constants.barIcon;
        break;
      case ActivityType.restaurant:
        title = "Restaurant";
        iconPath = Constants.restaurantIcon;
        break;
      case ActivityType.discovering:
        title = "Découvrir";
        iconPath = Constants.discoveringIcon;
        break;
      case ActivityType.shopping:
        title = "Shopping";
        iconPath = Constants.shoppingIcon;
        break;
      case ActivityType.snacking:
        title = "Petite faim";
        iconPath = Constants.snackingIcon;
        break;
    }

    return ActivityContainer(
        title: title,
        color: Constants.secondaryColor,
        iconPath: iconPath,
        onTap: null,
        changeColorOnTap: false,
        isActive: true);
  }
  static ImageIcon fromActivityTypeToIconAsset(ActivityType activityType,
      {double sizeIcon = 40}) {
    var url = Constants.discoveringIcon;

    switch (activityType) {
      case ActivityType.random:
        url = Constants.randomIcon;
        break;
      case ActivityType.discovering:
        url = Constants.discoveringIcon;
        break;
      case ActivityType.restaurant:
        url = Constants.restaurantIcon;
        break;
      case ActivityType.bar:
        url = Constants.barIcon;
        break;
      case ActivityType.shopping:
        url = Constants.shoppingIcon;
        break;
      case ActivityType.snacking:
        url = Constants.snackingIcon;
        break;
    }

    return ImageIcon(
      AssetImage(url),
      size: sizeIcon,
    );
  }
}
