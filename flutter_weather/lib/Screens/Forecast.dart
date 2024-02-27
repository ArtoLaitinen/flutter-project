import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherData {
  final String date;
  final String iconID;
  final double temperature;

  WeatherData(this.date, this.iconID, this.temperature);

}


class Forecast extends StatefulWidget {

  final String cityName;

  const Forecast({super.key, required this.cityName});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {

  List<WeatherData> weatherForecast = [];

  @override
  void initState() {
    super.initState();
    fetchForecast();
  }

  void fetchForecast() async {
    Uri uri = Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=${widget.cityName}&units=metric&appid=dba60f59482d08e0f171893a7c1214b6");
    var response = await http.get(uri);
    if( response.statusCode == 200) {
      var weatherData = json.decode(response.body);
      setState(() {
        weatherForecast = parseWeatherData(weatherData);
      });
    }
  }

  List<WeatherData> parseWeatherData(dynamic weatherData) {
    List<WeatherData> forecastList = [];

    for (var data in weatherData['list']) {
      String date = data['dt_txt'];
      String iconID = data['weather'][0]['icon'];
      double temperature = data['main']['temp'].toDouble();
      forecastList.add(WeatherData(date, iconID, temperature));
    }
    return forecastList;
  }

  @override
  Widget build(BuildContext context) {
    print("");
    print("");
    print("");
    print("");
    print("");
    print("forecast state called");
    print("");
    print("");
    print("");
    print("");
    print("");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forecast"),
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
                  'https://openweathermap.org/img/wn/${weatherForecast[index].iconID}@4x.png',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(weatherForecast[index].date, style: const TextStyle(fontSize: 20)),
              subtitle: Text("${weatherForecast[index].temperature} °C", style: const TextStyle(fontSize: 20)),
            ),
          );
        },
      ),
    );
  }
}