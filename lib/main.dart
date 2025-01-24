import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/weather_view_model.dart';
import 'views/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: WeatherScreen(),
      ),
    );
  }
}
