import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/restaurant_item.dart';

class FavoriteListScreen extends StatelessWidget {
  static const routeName = '/favorites';

  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit'),
        centerTitle: true,
        backgroundColor: Colors.amber.shade800,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<FavoriteProvider>(context, listen: false)
            .loadFavorites(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Gagal loading favorit: ${snapshot.error}'));
          } else {
            return Consumer<FavoriteProvider>(
              builder: (ctx, favoriteData, _) {
                if (favoriteData.favorites.isEmpty) {
                  return const Center(child: Text('Belum ada favorit.'));
                } else {
                  return ListView.builder(
                    itemCount: favoriteData.favorites.length,
                    itemBuilder: (ctx, index) {
                      final restaurant = favoriteData.favorites[index];
                      return RestaurantItem(restaurant);
                    },
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
