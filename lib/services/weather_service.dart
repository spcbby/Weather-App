import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather.dart';

class WeatherService {
  final String? apiKey = dotenv.env['OPENWEATHER_API_KEY'];
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> getWeatherByCity(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Weather> getWeatherByCoordinates(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, List<Weather>>> getForecasts(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$baseUrl/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'hourly': (data['hourly'] as List)
            .take(24)
            .map((item) => Weather.fromJson(item))
            .toList(),
        'daily': (data['daily'] as List)
            .take(7)
            .map((item) => Weather.fromJson(item))
            .toList(),
      };
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}