import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';

class WeatherData {
  final String date;
  final String iconID;
  final int temperature;

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
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchForecast();
  }

  void fetchForecast() async {
    try{
      Uri uri = Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=${widget.cityName}&units=metric&appid=dba60f59482d08e0f171893a7c1214b6");
      var response = await http.get(uri);
      if( response.statusCode == 200) {
        var weatherData = json.decode(response.body);
        setState(() {
          weatherForecast = parseWeatherData(weatherData);
        });
      } else {
        setState(() {
          errorMessage = "Failed to fetch forecast data. \nPlease try again later.";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        errorMessage = "No internet connection. \nPlease check your network settings.";
      });
    } catch (e) {
      setState(() {
        errorMessage = "An unexpected error occurred. \nPlease try again later.";
      });
    }
  }

  List<WeatherData> parseWeatherData(dynamic weatherData) {
    List<WeatherData> forecastList = [];

    for (var data in weatherData['list']) {
      String date = DateFormat('dd.MM H:mm').format(DateTime.parse(data['dt_txt']));
      String iconID = data['weather'][0]['icon'];
      int temperature = data['main']['temp'].round();
      forecastList.add(WeatherData(date, iconID, temperature));
    }
    return forecastList;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.cityName} Forecast"),
      ),

      body: errorMessage != null
        ? Center(
            child: Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 30),
            ),
          )

        : weatherForecast.isEmpty
            ? const Center(child: CircularProgressIndicator( color: Colors.blue,))
            : ListView.builder(
                itemCount: weatherForecast.length,
                itemBuilder: (context, index) {
                  return Container(
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
                      title: Text(weatherForecast[index].date, style: const TextStyle(fontSize: 30)),
                      subtitle: Text("${weatherForecast[index].temperature} °C", style: const TextStyle(fontSize: 30, color: Colors.black)),
                    ),
                  );
                },
              ),
    );
  }
}