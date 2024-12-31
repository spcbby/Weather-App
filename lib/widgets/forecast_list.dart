import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/settings_provider.dart';
import 'package:intl/intl.dart';

class ForecastList extends StatelessWidget {
  final List<Weather> hourlyForecast;
  final List<Weather> dailyForecast;

  const ForecastList({
    super.key,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHourlyForecast(context),
        const Divider(),
        _buildDailyForecast(context),
      ],
    );
  }

  Widget _buildHourlyForecast(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Hourly Forecast',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyForecast.length,
            itemBuilder: (context, index) {
              return _HourlyForecastItem(weather: hourlyForecast[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDailyForecast(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '7-Day Forecast',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dailyForecast.length,
          itemBuilder: (context, index) {
            return _DailyForecastItem(weather: dailyForecast[index]);
          },
        ),
      ],
    );
  }
}

class _HourlyForecastItem extends StatelessWidget {
  final Weather weather;

  const _HourlyForecastItem({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        final temp = settings.isCelsius
            ? weather.temperature
            : (weather.temperature * 9 / 5) + 32;

        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(DateFormat('HH:mm').format(DateTime.now())),
              Icon(Icons.wb_sunny), // Replace with weather-specific icon
              Text('${temp.round()}°'),
            ],
          ),
        );
      },
    );
  }
}

class _DailyForecastItem extends StatelessWidget {
  final Weather weather;

  const _DailyForecastItem({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        final temp = settings.isCelsius
            ? weather.temperature
            : (weather.temperature * 9 / 5) + 32;

        return ListTile(
          leading: Icon(Icons.wb_sunny), // Replace with weather-specific icon
          title: Text(DateFormat('EEEE').format(DateTime.now())),
          trailing: Text('${temp.round()}°'),
        );
      },
    );
  }
}