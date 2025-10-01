import 'package:flutter/material.dart';
import 'package:flutter_movie_rating/features/movies/page/movies_page.dart';
import 'package:flutter_movie_rating/shared/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Rating',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MoviesPage(),
    );
  }
}
