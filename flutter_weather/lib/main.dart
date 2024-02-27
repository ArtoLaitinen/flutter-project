import 'package:flutter/material.dart';
import 'package:flutter_weather/Screens/CurrentWeather.dart';
import 'package:flutter_weather/Screens/Forecast.dart';


void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  String cityName = 'Tampere';
  double temperature = 0;
  double windSpeed = 0;
  String iconID = "10d";

  // Function to update the city
  void updateCity(String newCity) {
    setState(() {
      cityName = newCity;
    });
  }

  // Function to update the weather data
  void updateWeatherData(double temp, double speed, String icon) {
    setState(() {
      temperature = temp;
      windSpeed = speed;
      iconID = icon;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.thermostat),
            icon: Icon(Icons.thermostat_outlined),
            label: 'Current Weather',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Forecast',
          ),

        ],
      ),
      body: <Widget>[
        CurrentWeather(
          cityName: cityName,
          updateCity: updateCity,
          temperature: temperature,
          windSpeed: windSpeed,
          iconID: iconID,
          updateWeatherData: updateWeatherData,
        ),
        Forecast(cityName: cityName),
      ][currentPageIndex],
    );
  }
}
