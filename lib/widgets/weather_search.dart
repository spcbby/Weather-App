import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class WeatherSearch extends StatelessWidget {
  const WeatherSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search city...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          context.read<WeatherProvider>().fetchWeatherByCity(value);
        }
      },
    );
  }
}