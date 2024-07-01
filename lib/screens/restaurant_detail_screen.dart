import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen(this.restaurant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        centerTitle: true,
        backgroundColor: Colors.amber.shade700,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  restaurant.pictureID,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                restaurant.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                restaurant.city,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const SizedBox(width: 4),
                  Icon(
                    Icons.star,
                    color: Colors.amber.shade700,
                  ),
                  Text(
                    '${restaurant.rating}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade700),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                restaurant.description,
                textAlign: TextAlign.justify,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Foods',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              ...restaurant.menus.foods.map((food) {
                return ListTile(
                  leading: const Icon(Icons.fastfood),
                  title: Text(food.name),
                );
              }),
              const SizedBox(height: 16.0),
              const Text(
                'Drinks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              ...restaurant.menus.drinks.map((drink) {
                return ListTile(
                  leading: const Icon(Icons.local_drink),
                  title: Text(drink.name),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
