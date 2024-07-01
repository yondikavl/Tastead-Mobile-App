import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantDetailScreen(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(restaurant.pictureID),
              SizedBox(height: 16.0),
              Text(
                restaurant.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                restaurant.city,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 16.0),
              Text(
                'Rating: ${restaurant.rating}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16.0),
              Text(
                restaurant.description,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 16.0),
              Text(
                'Foods',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              ...restaurant.menus.foods.map((food) {
                return ListTile(
                  leading: Icon(Icons.fastfood),
                  title: Text(food.name),
                );
              }).toList(),
              SizedBox(height: 16.0),
              Text(
                'Drinks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              ...restaurant.menus.drinks.map((drink) {
                return ListTile(
                  leading: Icon(Icons.local_drink),
                  title: Text(drink.name),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
