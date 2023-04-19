import 'dart:convert';

import 'package:whatodo/constants/constant.dart';

import '../utils/enum_filters.dart';
import 'generated_options._place.dart';

class ResultPlaceModel {
  String id;
  String placeId;
  String name;
  String address;
  num? rating;
  double latitude;
  double longitude;
  List<String> types;
  num? userRatingsTotals;
  GeneratedOptions generatedOptions;
  String? urlPictureReference;
  DateTime updatedAt;

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
      this.urlPictureReference,
      this.updatedAt);

  factory ResultPlaceModel.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    GeneratedOptions generatedOptions = GeneratedOptions(
      ActivityType.values[json['generatedOptions']['activityType']],
      MovingType.values[json['generatedOptions']['movingType']],
      json['generatedOptions']['maxHour'],
      json['generatedOptions']['maxMin']
      //PriceType.values[json['generatedOptions']['priceType']],
    );

    String? pitureUrl;

    if (json['place']['photos'] != null &&
        json['place']['photos'].length > 0 &&
        json['place']['photos'][0]['photo_reference'] != null) {
      pitureUrl = Constants.urlPictureGoogleApi +
          json['place']['photos'][0]['photo_reference'];
    }
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
        generatedOptions,
      pitureUrl,
      DateTime.parse(json['updatedAt']));
  }
}
