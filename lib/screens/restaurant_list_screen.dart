import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../widgets/restaurant_item.dart';

class RestaurantListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200, // Tinggi hero section
            padding: const EdgeInsets.all(24),
            color: Colors.amber.shade800,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Tastead',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Rekomendasi restoran favoritmu!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<RestaurantProvider>(context, listen: false)
                  .fetchRestaurants(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Gagal loading data'));
                } else {
                  return Consumer<RestaurantProvider>(
                    builder: (ctx, restaurantData, _) {
                      if (restaurantData.restaurants.isEmpty) {
                        return Center(child: Text('Restoran tidak ditemukan.'));
                      } else {
                        return ListView.builder(
                          itemCount: restaurantData.restaurants.length,
                          itemBuilder: (ctx, index) =>
                              RestaurantItem(restaurantData.restaurants[index]),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
