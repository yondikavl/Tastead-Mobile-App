import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];

  List<Restaurant> get restaurants => _restaurants;

  Future<void> fetchRestaurants() async {
    final String response =
        await rootBundle.loadString('assets/restaurants.json');
    final data = json.decode(response) as Map<String, dynamic>;
    _restaurants = List<Restaurant>.from(
        data['restaurants'].map((item) => Restaurant.fromJson(item)));
    notifyListeners();
  }
}
