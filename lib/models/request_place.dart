import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/enum_filters.dart';

class RequestPlace {
  final List<ActivityType> activities;
  //final List<PriceType> priceTypes;
  final List<MovingType> movingTypes;
  final double latitude;
  final double longitude;
  final int maxHour;
  final int maxMin;

  RequestPlace(this.activities, /*this.priceTypes,*/ this.movingTypes,
      this.latitude, this.longitude, this.maxHour, this.maxMin);

  Map toJson() => {
        'activities': activities.map((activity) => activity.index).toList(),
        //'priceTypes': priceTypes.map((priceType) => priceType.index).toList(),
        'movingTypes': movingTypes.map((movingType) => movingType.index).toList(),
        'latitude': latitude,
        'longitude': longitude,
        'maxHour': maxHour,
        'maxMin': maxMin,
      };
}
