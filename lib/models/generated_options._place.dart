import 'dart:convert';

import 'package:whatodo/utils/enum_filters.dart';

class GeneratedOptions {
  ActivityType activityType;
  MovingType movingType;
  PriceType priceType;
  double travellingDuration;

  GeneratedOptions(
    this.activityType,
    this.movingType,
    this.priceType,
    this.travellingDuration,
  );

  factory GeneratedOptions.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return GeneratedOptions(
      json['activityType'],
      json['movingType'],
      json['priceType'],
      json['travellingDuration'],
    );
  }
}
