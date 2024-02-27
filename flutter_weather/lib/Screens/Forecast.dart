import 'package:flutter/material.dart';

class WeatherData {
  final double temperature;

  WeatherData(this.temperature);

}

final List<WeatherData> weatherForecast = [
  WeatherData(1),
  WeatherData(2),
  WeatherData(3),
  WeatherData(4),
  WeatherData(5),
  WeatherData(6),
  WeatherData(7),
  WeatherData(8),
  WeatherData(9),
  WeatherData(10),
  WeatherData(11),

];

class Forecast extends StatefulWidget {
  //const Forecast({super.key});

  final String cityName;

  const Forecast({super.key, required this.cityName});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName),
      ),
      body: ListView.builder(
        itemCount: weatherForecast.length,
        itemBuilder: (context, index) {
          return  Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              leading: Container(
                width: 80,
                height: 80,
                child: Image.network(
                  'https://openweathermap.org/img/wn/10d@4x.png',
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text("DATE AND TIME", style: TextStyle(fontSize: 20),),
              subtitle: Text("${weatherForecast[index].temperature} °C", style: const TextStyle(fontSize: 20)),
            ),
          );
        },
      ),
    );
  }
}