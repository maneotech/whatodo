import '../constants/constant.dart';
import '../repositories/shared_pref.dart';

class UtilService {

  static getMinutesFromHoursMinutes(int hours, int minutes){
    return hours * 60 + minutes;
  }

  static Future<bool> isFirstOpenApp() async {
    SharedPref sharedPref = SharedPref();
    String? jsonString =
        await sharedPref.read(Constants.sharedPrefKeyFirstOpenApp);

    if (jsonString != null && jsonString.isNotEmpty) {
      return false;
    } else {
      await sharedPref.save(Constants.sharedPrefKeyFirstOpenApp, "true");
      return true;
    }
  }
}