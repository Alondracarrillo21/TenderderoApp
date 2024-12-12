import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  final String apiKey = "106b83fffb03579c5afe78b088b9b898"; // Reemplaza con tu clave API
  final String city = "Merida"; // Cambia por la ciudad deseada
  List<Map<String, dynamic>> forecast = [];
  String nextRainTime = "Sin datos";

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$apiKey";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Map<String, dynamic>> fetchedForecast = [];
        for (int i = 0; i < 6; i++) {
          fetchedForecast.add({
            "hora": data["list"][i]["dt_txt"].substring(11, 16),
            "temperatura": data["list"][i]["main"]["temp"],
            "icono": data["list"][i]["weather"][0]["icon"],
            "descripcion": data["list"][i]["weather"][0]["description"],
            "lluvia": data["list"][i]["rain"] != null
                ? data["list"][i]["rain"]["3h"]
                : 0.0,
          });
        }

        // Encuentra la próxima hora de lluvia
        String lluviaProxima = "Sin datos";
        for (var item in data["list"]) {
          if (item["rain"] != null && item["rain"]["3h"] > 0) {
            lluviaProxima = item["dt_txt"].substring(11, 16);
            break;
          }
        }

        setState(() {
          forecast = fetchedForecast;
          nextRainTime = lluviaProxima;
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error obteniendo datos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF13596B),
      appBar: AppBar(
        backgroundColor: Color(0xFF13596B),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Pronostico del clima',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: forecast.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Clima Actual",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${forecast[0]["temperatura"].toStringAsFixed(1)}°C, ${forecast[0]["descripcion"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF13596B),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          nextRainTime != "Sin datos"
                              ? "Próxima lluvia a las $nextRainTime"
                              : "No se esperan lluvias próximamente",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF13596B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Pronóstico para las próximas horas",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            pronosticoItem(forecast[0]),
                            pronosticoItem(forecast[1]),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            pronosticoItem(forecast[2]),
                            pronosticoItem(forecast[3]),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            pronosticoItem(forecast[4]),
                            pronosticoItem(forecast[5]),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget pronosticoItem(Map<String, dynamic> item) {
    return Container(
      width: 180, // Ancho de los recuadros
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item["hora"],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF92D4E3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.network(
                "https://openweathermap.org/img/wn/${item["icono"]}@2x.png",
                width: 50,
                height: 50,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "${item["temperatura"].toStringAsFixed(1)}°C",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Text(
            item["descripcion"],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherForecast(),
    ));
