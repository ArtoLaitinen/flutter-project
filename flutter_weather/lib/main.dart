import 'package:flutter/material.dart';
import 'package:flutter_weather/Screens/CurrentWeather.dart';
import 'package:flutter_weather/Screens/Forecast.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "My App",
      initialRoute: '/',
      routes: {
        '/':(context) => const CurrentWeather(),
        '/second':(context) => const Forecast(),
      },
    );
  }
}