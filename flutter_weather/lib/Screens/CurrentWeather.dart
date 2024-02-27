import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({super.key});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  String cityName = "Tampere";
  String iconID = "10d";
  double temperature = 0;
  double windSpeed = 0;
  String inputCity = "";

  void fetchWeatherData() async {
    Uri uri = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$inputCity&units=metric&appid=dba60f59482d08e0f171893a7c1214b6");
    var response = await http.get(uri);
    if( response.statusCode == 200) {
      var weatherData = json.decode(response.body);
      setState(() {
        temperature = weatherData['main']['temp'];
        windSpeed = weatherData['wind']['speed'];
        cityName = weatherData['name'];
        iconID = weatherData['weather'][0]['icon'];
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
                  cityName,
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
                    Image.network('https://openweathermap.org/img/wn/$iconID@4x.png'),
                     Column(
                      children: <Widget>[
                        Text(
                          '$temperature °C',
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),

                        Text(
                          '$windSpeed m/s',
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
                    TextField(
                      decoration: const InputDecoration(labelText: 'ENTER A CITY'),
                      onChanged:(value) {
                        setState(() {
                          inputCity = value;
                        });
                      },
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
