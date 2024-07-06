import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_restaurant.dart';
import '../providers/restaurant_provider.dart';
import '../providers/favorite_provider.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailScreen(this.restaurantId, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<RestaurantProvider>(context, listen: false)
          .fetchRestaurantDetail(restaurantId),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Center(child: Text('Gagal memuat data: ${snapshot.error}')),
          );
        } else {
          return Consumer2<RestaurantProvider, FavoriteProvider>(
            builder: (ctx, restaurantProvider, favoriteProvider, _) {
              final restaurant = restaurantProvider.restaurantDetail;
              if (restaurant == null) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Detail Restoran'),
                  ),
                  body: const Center(child: Text('Data tidak ditemukan')),
                );
              }
              final isFavorite = favoriteProvider.isFavorite(restaurant.id);
              return Scaffold(
                appBar: AppBar(
                  title: Text(restaurant.name),
                  centerTitle: true,
                  backgroundColor: Colors.amber.shade800,
                  titleTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                  actions: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        final favoriteRestaurant = FavoriteRestaurant(
                          id: restaurant.id,
                          name: restaurant.name,
                          description: restaurant.description,
                          pictureId: restaurant.pictureId,
                          city: restaurant.city,
                          rating: restaurant.rating,
                        );
                        if (isFavorite) {
                          favoriteProvider.removeFavorite(restaurant.id);
                        } else {
                          favoriteProvider.addFavorite(favoriteRestaurant);
                        }
                      },
                    ),
                  ],
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
                            'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.place,
                              color: Colors.grey,
                              size: 16,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              restaurant.city,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
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
                          'Makanan',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                          'Minuman',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
            },
          );
        }
      },
    );
  }
}
