import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../constants/constant.dart';
import '../repositories/shared_pref.dart';

class LocationProvider with ChangeNotifier {
  double? _lat;
  double? _lng;
  String _currentAddress = "";

  double? get lat => _lat;
  double? get lng => _lng;
  String get currentAddress => _currentAddress;

  Future<bool> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return false;

    bool result = false;
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _lat = position.latitude;
      _lng = position.longitude;
      result = await _getAddressFromLatLng();
      if (_currentAddress.isNotEmpty) {
        saveLocationToDisk(_lat!, _lng!, _currentAddress);
      }
    } catch (e) {
      print(e);
      result = false;
    }
    return result;
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Location services are disabled. Please enable the services')));*/
      return false;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        /*ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));*/
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));*/
      return false;
    }

    return true;
  }

  Future<bool> _getAddressFromLatLng() async {
    bool result = false;

    if (lat != null && lng != null) {
      await placemarkFromCoordinates(lat!, lng!)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        _currentAddress =
            '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';

        result = true;
      }).catchError((e) {
        result = true;
        //result = false;
      });
    } else {
      result = false;
    }

    return result;
  }

  getLocationFromDisk() async {
    SharedPref sharedPref = SharedPref();
    String? lat = await sharedPref.read(Constants.sharedPrefKeyLat);
    String? lng = await sharedPref.read(Constants.sharedPrefKeyLng);
    String? address = await sharedPref.read(Constants.sharedPrefKeyAddress);

    if (lat != null && lng != null && address != null) {
      _lat = double.parse(lat);
      _lng = double.parse(lng);
      _currentAddress = address;
      notifyListeners();
    }
  }

  Future<void> saveLocationToDisk(
      double lat, double lng, String address) async {
    SharedPref sharedPref = SharedPref();
    await sharedPref.save(Constants.sharedPrefKeyLat, lat.toString());
    await sharedPref.save(Constants.sharedPrefKeyLng, lng.toString());
    await sharedPref.save(Constants.sharedPrefKeyAddress, address);
  }
}
