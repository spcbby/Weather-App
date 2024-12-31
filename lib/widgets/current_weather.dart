import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/settings_provider.dart';
import 'package:intl/intl.dart';

class CurrentWeather extends StatelessWidget {
  final Weather? weather;

  const CurrentWeather({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    if (weather == null) return const SizedBox.shrink();

    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        final temp = settings.isCelsius
            ? weather!.temperature
            : (weather!.temperature * 9 / 5) + 32;

        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                weather!.location,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                '${temp.round()}°${settings.isCelsius ? 'C' : 'F'}',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                weather!.description.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              _buildWeatherDetails(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeatherDetails(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDetailItem(
          context,
          'Wind',
          '${weather!.windSpeed} m/s',
          Icons.air,
        ),
        _buildDetailItem(
          context,
          'Humidity',
          '${weather!.humidity}%',
          Icons.water_drop,
        ),
        _buildDetailItem(
          context,
          'UV Index',
          weather!.uvIndex.toString(),
          Icons.wb_sunny,
        ),
      ],
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(label),
        Text(value),
      ],
    );
  }
}