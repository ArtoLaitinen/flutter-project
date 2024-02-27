import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrentWeather extends StatefulWidget {
  final String cityName;
  final Function(String) updateCity;
  final double temperature;
  final double windSpeed;
  final String iconID;
  final Function(double, double, String) updateWeatherData;


  const CurrentWeather({
    super.key,
    required this.cityName,
    required this.updateCity,
    required this.temperature,
    required this.windSpeed,
    required this.iconID,
    required this.updateWeatherData,
  });

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  String inputCity = "";


  void fetchWeatherData() async {
    Uri uri = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$inputCity&units=metric&appid=dba60f59482d08e0f171893a7c1214b6");
    var response = await http.get(uri);
    if( response.statusCode == 200) {
      var weatherData = json.decode(response.body);
      setState(() {
        widget.updateCity(weatherData['name']);
        widget.updateWeatherData(weatherData['main']['temp'], weatherData['wind']['speed'], weatherData['weather'][0]['icon'] );
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: const Text("Current Weather"),
        ),

        body:  SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  widget.cityName,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(5, 50, 20, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network('https://openweathermap.org/img/wn/${widget.iconID}@4x.png'),
                     Column(
                      children: <Widget>[
                        Text(
                          '${widget.temperature} °C',
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),

                        Text(
                          '${widget.windSpeed} m/s',
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),

                      ],
                    )
                  ],
                )
              ),


              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            decoration: const InputDecoration(labelText: 'ENTER A CITY'),
                            onChanged:(value) {
                              setState(() {
                                inputCity = value;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                          },
                          icon: const Icon(Icons.my_location),
                          iconSize: 40
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 60),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        fetchWeatherData();
                      },
                      child: const Text("GET CURRENT WEATHER", style: TextStyle(color: Colors.white))
                    ),
                  ],
                )
              ),

            ],
          )
        ),

      );
  }
}
