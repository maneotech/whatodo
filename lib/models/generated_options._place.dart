import 'dart:convert';

import 'package:whatodo/utils/enum_filters.dart';

class GeneratedOptions {
  ActivityType activityType;
  MovingType movingType;
  int maxHour;
  int maxMin;
  //PriceType priceType;
  //double travellingDuration;

  GeneratedOptions(this.activityType, this.movingType, this.maxHour, this.maxMin
      //this.priceType,
      //this.travellingDuration,
      );

  factory GeneratedOptions.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return GeneratedOptions(
      json['activityType'], json['movingType'],
      json['maxHour'], json['maxMin'],
      //json['priceType'],
      //json['travellingDuration'],
    );
  }
}
