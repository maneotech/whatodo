import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/enum_filters.dart';

class ResultPlaceModel {
  String id;
  String name;
  String address;
  double rating;
  LatLng location;
  List<String> types;
  String logoUrl;
  List<String> picturesUrl;
  int userRatingsTotals;
  ActivityType activityType;
  PriceType priceType;
  MovingType movingType;
  double travellingDuration;

  ResultPlaceModel(
    this.id,
    this.name,
    this.address,
    this.rating,
    this.location,
    this.types,
    this.logoUrl,
    this.picturesUrl,
    this.userRatingsTotals,
    this.activityType,
    this.priceType,
    this.movingType,
    this.travellingDuration,
  );

  factory ResultPlaceModel.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return ResultPlaceModel(
      json['id'],
      json['name'],
      json['address'],
      json['rating'],
      json['location'],
      json['types'],
      json['logoUrl'],
      json['picturesUrl'],
      json['userRatingsTotals'],
      json['activityType'],
      json['priceType'],
      json['movingType'],
      json['travellingDuration'],
    );
  }
}
