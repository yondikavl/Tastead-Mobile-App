import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../widgets/restaurant_item.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final TextEditingController _searchController = TextEditingController();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Tastead',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Rekomendasi restoran favoritmu!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari restoran...',
                    hintStyle: TextStyle(color: Colors.black54),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  ),
                  onSubmitted: (query) {
                    if (query.isNotEmpty) {
                      Provider.of<RestaurantProvider>(context, listen: false)
                          .searchRestaurants(query);
                    } else {
                      Provider.of<RestaurantProvider>(context, listen: false)
                          .fetchRestaurants();
                    }
                  },
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
                  return Center(
                      child: Text('Gagal loading data: ${snapshot.error}'));
                } else {
                  return Consumer<RestaurantProvider>(
                    builder: (ctx, restaurantData, _) {
                      final restaurants = _searchController.text.isEmpty
                          ? restaurantData.restaurants
                          : restaurantData.searchResults;
                      if (restaurants.isEmpty) {
                        return Center(child: Text('Restoran tidak ditemukan.'));
                      } else {
                        return ListView.builder(
                          itemCount: restaurants.length,
                          itemBuilder: (ctx, index) =>
                              RestaurantItem(restaurants[index]),
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
