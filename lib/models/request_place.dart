import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/enum_filters.dart';

class RequestPlace {
  final List<ActivityType> activities;
  final List<PriceType> priceTypes;
  final List<MovingType> movingTypes;
  final LatLng latLng;
  final String address;
  final int maxHour;
  final int maxMin;

  RequestPlace(this.activities, this.priceTypes, this.movingTypes,
      this.latLng, this.address, this.maxHour, this.maxMin);
}
