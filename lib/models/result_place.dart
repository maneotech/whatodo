import 'dart:convert';

import '../utils/enum_filters.dart';
import 'generated_options._place.dart';

class ResultPlaceModel {
  String id;
  String placeId;
  String name;
  String address;
  double rating;
  double latitude;
  double longitude;
  List<String> types;
  int userRatingsTotals;
  GeneratedOptions generatedOptions;

  ResultPlaceModel(
    this.id,
    this.placeId,
    this.name,
    this.address,
    this.rating,
    this.latitude,
    this.longitude,
    this.types,
    this.userRatingsTotals,
    this.generatedOptions,
  );

  factory ResultPlaceModel.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    GeneratedOptions generatedOptions = GeneratedOptions(
      ActivityType.values[json['generatedOptions']['activityType']],
      MovingType.values[json['generatedOptions']['movingType']],
      PriceType.values[json['generatedOptions']['priceType']],
      5,
    );

    return ResultPlaceModel(
        json['_id'],
        json['place']['place_id'],
        json['place']['name'],
        json['place']['vicinity'],
        json['place']['rating'],
        json['place']['geometry']['location']['lat'],
        json['place']['geometry']['location']['lng'],
        List<String>.from(json['place']['types']),
        json['place']['user_ratings_total'],
        generatedOptions);
  }
}
