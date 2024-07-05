import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];

  List<Restaurant> get restaurants => _restaurants;

  Future<void> fetchRestaurants() async {
    const url = 'https://restaurant-api.dicoding.dev/list';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['restaurants'] != null) {
          _restaurants = List<Restaurant>.from(
            data['restaurants'].map((item) => Restaurant.fromJson(item)),
          );
        } else {
          throw Exception('No data found');
        }

        notifyListeners();
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }

  Restaurant findRestaurantById(String id) {
    return _restaurants.firstWhere((restaurant) => restaurant.id == id);
  }

  Future<void> searchRestaurants(String query) async {
    final url = 'https://restaurant-api.dicoding.dev/search?q=$query';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['restaurants'] != null) {
          _restaurants = List<Restaurant>.from(
            data['restaurants'].map((item) => Restaurant.fromJson(item)),
          );
        } else {
          throw Exception('No data found');
        }

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error searching restaurants: $error');
      throw error;
    }
  }
}
