import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/restaurant_provider.dart';
import './screens/restaurant_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
      ],
      child: MaterialApp(
        title: 'Tastead',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: RestaurantListScreen(),
      ),
    );
  }
}
