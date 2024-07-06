import 'package:flutter/material.dart';
import 'package:tastead/models/favorite_restaurant.dart';
import '../screens/restaurant_detail_screen.dart';

class RestaurantItem extends StatelessWidget {
  final dynamic restaurant;

  const RestaurantItem(this.restaurant, {super.key});

  @override
  Widget build(BuildContext context) {
    final isFavorite = restaurant is FavoriteRestaurant;
    final pictureId = isFavorite ? restaurant.pictureId : restaurant.pictureId;
    final name = isFavorite ? restaurant.name : restaurant.name;
    final city = isFavorite ? restaurant.city : restaurant.city;
    final rating = isFavorite ? restaurant.rating : restaurant.rating;
    final id = isFavorite ? restaurant.id : restaurant.id;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.indigo.shade50,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: ListTile(
          leading: Container(
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/small/$pictureId',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            city,
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            rating.toString(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade700),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RestaurantDetailScreen(id),
              ),
            );
          },
        ),
      ),
    );
  }
}
