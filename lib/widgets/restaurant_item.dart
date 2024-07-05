import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../screens/restaurant_detail_screen.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantItem(this.restaurant);

  @override
  Widget build(BuildContext context) {
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
                  'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          title: Text(
            restaurant.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            restaurant.city,
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            restaurant.rating.toString(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade700),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RestaurantDetailScreen(restaurant.id),
              ),
            );
          },
        ),
      ),
    );
  }
}
