class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pictureId: json['pictureId'] ?? '',
      city: json['city'] ?? '',
      rating: json['rating']?.toDouble() ?? 0.0,
      menus: json['menus'] != null
          ? Menus.fromJson(json['menus'])
          : Menus(foods: [], drinks: []),
    );
  }
}

class Menus {
  final List<Category> foods;
  final List<Category> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    var foodsList = json['foods'] as List? ?? [];
    var drinksList = json['drinks'] as List? ?? [];

    List<Category> foods = foodsList.map((i) => Category.fromJson(i)).toList();
    List<Category> drinks =
        drinksList.map((i) => Category.fromJson(i)).toList();

    return Menus(
      foods: foods,
      drinks: drinks,
    );
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? '',
    );
  }
}
