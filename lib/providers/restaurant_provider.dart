import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  List<Restaurant> _searchResults = [];
  Restaurant? _restaurantDetail;

  List<Restaurant> get restaurants => _restaurants;
  List<Restaurant> get searchResults => _searchResults;
  Restaurant? get restaurantDetail => _restaurantDetail;

  Future<void> fetchRestaurants() async {
    const url = 'https://restaurant-api.dicoding.dev/list';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data['restaurants'] != null) {
        _restaurants = List<Restaurant>.from(
          data['restaurants'].map((item) => Restaurant.fromJson(item)),
        );
      } else {
        throw Exception('Data tidak ditemukan');
      }
      notifyListeners();
    } else {
      throw Exception('Gagal loading data. Status: ${response.statusCode}');
    }
  }

  Future<void> fetchRestaurantDetail(String id) async {
    final url = 'https://restaurant-api.dicoding.dev/detail/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data['restaurant'] != null) {
        _restaurantDetail = Restaurant.fromJson(data['restaurant']);
      } else {
        throw Exception('Data tidak ditemukan');
      }
      notifyListeners();
    } else {
      throw Exception('Gagal loading data. Status: ${response.statusCode}');
    }
  }

  Future<void> searchRestaurants(String query) async {
    final url = 'https://restaurant-api.dicoding.dev/search?q=$query';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data['restaurants'] != null) {
        _searchResults = List<Restaurant>.from(
          data['restaurants'].map((item) => Restaurant.fromJson(item)),
        );
      } else {
        throw Exception('Data tidak ditemukan');
      }
      notifyListeners();
    } else {
      throw Exception('Gagal loading data.');
    }
  }
}
