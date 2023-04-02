import '../components/activity_container.dart';
import '../constants/constant.dart';

class ActivityService {
  static ActivityContainer getCulturelBloc(Function? callback, bool isActive) {
    return ActivityContainer(
        title: "Culturel",
        color: Constants.primaryColor,
        iconPath: Constants.culturelIcon,
        onTap: callback != null ? () => callback() : null,
        isActive: isActive);
  }

  static ActivityContainer getSportBloc(Function? callback, bool isActive) {
    return ActivityContainer(
      title: "Sport",
      color: Constants.thirdColor,
      iconPath: Constants.sportIcon,
      isActive: isActive,
      onTap: callback != null ? () => callback() : null,
    );
  }

  static ActivityContainer getRestaurantBloc(
      Function? callback, bool isActive) {
    return ActivityContainer(
      title: "Restaurant",
      color: Constants.thirdColor,
      iconPath: Constants.restaurantIcon,
      isActive: isActive,
      onTap: callback != null ? () => callback() : null,
    );
  }

  static ActivityContainer getBarBloc(Function? callback, bool isActive) {
    return ActivityContainer(
      title: "Bar",
      color: Constants.secondaryColor,
      iconPath: Constants.barIcon,
      isActive: isActive,
      onTap: callback != null ? () => callback() : null,
    );
  }

  static ActivityContainer getShoppingBloc(Function? callback, bool isActive) {
    return ActivityContainer(
      title: "Shopping",
      color: Constants.secondaryColor,
      iconPath: Constants.shoppingIcon,
      isActive: isActive,
      onTap: callback != null ? () => callback() : null,
    );
  }

  static ActivityContainer getSnackingBloc(Function? callback, bool isActive) {
    return ActivityContainer(
      title: "Petite faim",
      color: Constants.primaryColor,
      iconPath: Constants.snackingIcon,
      isActive: isActive,
      onTap: callback != null ? () => callback() : null,
    );
  }
}
