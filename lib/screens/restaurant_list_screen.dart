import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../widgets/restaurant_item.dart';

class RestaurantListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Restoran'),
        centerTitle: true,
        backgroundColor: Colors.amber.shade700,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<RestaurantProvider>(context, listen: false)
            .fetchRestaurants(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Gagal loading data'));
          } else {
            return Consumer<RestaurantProvider>(
              builder: (ctx, restaurantData, _) {
                if (restaurantData.restaurants.isEmpty) {
                  return const Center(child: Text('Restoran tidak ditemukan.'));
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
    );
  }
}
