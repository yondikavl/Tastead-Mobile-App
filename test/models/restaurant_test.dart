import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tastead/models/restaurant.dart';

void main() {
  test('JSON parsing should return a valid Restaurant object', () {
    const jsonString = '''
    {
      "id": "1",
      "name": "Test Restaurant",
      "description": "Test Description",
      "pictureId": "1",
      "city": "Test City",
      "rating": 4.5,
      "menus": {
        "foods": [{"name": "Test Food"}],
        "drinks": [{"name": "Test Drink"}]
      }
    }
    ''';

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final restaurant = Restaurant.fromJson(jsonMap);

    expect(restaurant.id, "1");
    expect(restaurant.name, "Test Restaurant");
    expect(restaurant.description, "Test Description");
    expect(restaurant.pictureId, "1");
    expect(restaurant.city, "Test City");
    expect(restaurant.rating, 4.5);
    expect(restaurant.menus.foods.first.name, "Test Food");
    expect(restaurant.menus.drinks.first.name, "Test Drink");
  });
}
