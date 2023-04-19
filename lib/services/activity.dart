import 'package:flutter/material.dart';
import 'package:whatodo/utils/enum_filters.dart';

import '../components/activity_container.dart';
import '../constants/constant.dart';

class ActivityService { 
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
