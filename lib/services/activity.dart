import '../components/activity_container.dart';
import '../constants/constant.dart';

class ActivityService {
  static ActivityContainer getCulturelBloc(Function? callback) {
    return ActivityContainer(
      title: "Culturel",
      color: Constants.primaryColor,
      iconPath: Constants.culturelIcon,
      onTap: () => callback,
    );
  }

  static ActivityContainer getSportBloc(Function? callback) {
    return ActivityContainer(
        title: "Sport",
        color: Constants.secondaryColor,
        iconPath: Constants.sportIcon,
        onTap: () => callback);
  }

  static ActivityContainer getRestaurantBloc(Function? callback) {
    return ActivityContainer(
        title: "Restaurant",
        color: Constants.thirdColor,
        iconPath: Constants.restaurantIcon,
        onTap: () => callback);
  }

  static ActivityContainer getBarBloc(Function? callback) {
    return ActivityContainer(
        title: "Bar",
        color: Constants.thirdColor,
        iconPath: Constants.barIcon,
        onTap: () => callback);
  }

  static ActivityContainer getShoppingBloc(Function? callback) {
    return ActivityContainer(
        title: "Shopping",
        color: Constants.primaryColor,
        iconPath: Constants.shoppingIcon,
        onTap: () => callback);
  }

  static ActivityContainer getGroceryBloc(Function? callback) {
    return ActivityContainer(
        title: "Alimentation",
        color: Constants.secondaryColor,
        iconPath: Constants.groceryIcon,
        onTap: () => callback);
  }
}
