import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/current_weather.dart';
import 'package:weather_app/widgets/weather_search.dart';
import 'package:weather_app/widgets/forecast_list.dart';
import 'package:weather_app/widgets/settings_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchCurrentLocationWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (weatherProvider.error != null) {
            return Center(child: Text(weatherProvider.error!));
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                actions: const [SettingsButton()],
                title: const Text('Weather App'),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: WeatherSearch(),
                ),
              ),
              SliverToBoxAdapter(
                child: CurrentWeather(
                  weather: weatherProvider.currentWeather,
                ),
              ),
              SliverToBoxAdapter(
                child: ForecastList(
                  hourlyForecast: weatherProvider.hourlyForecast,
                  dailyForecast: weatherProvider.dailyForecast,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}