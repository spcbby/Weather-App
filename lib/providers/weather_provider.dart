import 'package:flutter/foundation.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/services/location_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _currentWeather;
  List<Weather> _hourlyForecast = [];
  List<Weather> _dailyForecast = [];
  bool _isLoading = false;
  String? _error;

  Weather? get currentWeather => _currentWeather;
  List<Weather> get hourlyForecast => _hourlyForecast;
  List<Weather> get dailyForecast => _dailyForecast;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();

  Future<void> fetchCurrentLocationWeather() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final position = await _locationService.getCurrentLocation();
      final weather = await _weatherService.getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );

      _currentWeather = weather;
      await fetchForecasts(position.latitude, position.longitude);
    } catch (e) {
      _error = 'Failed to fetch weather data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByCity(String city) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final weather = await _weatherService.getWeatherByCity(city);
      _currentWeather = weather;
      
      // Fetch forecasts using the coordinates from the current weather
      await fetchForecasts(0, 0); // You would use actual coordinates here
    } catch (e) {
      _error = 'City not found';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchForecasts(double lat, double lon) async {
    try {
      final forecasts = await _weatherService.getForecasts(lat, lon);
      _hourlyForecast = forecasts['hourly'];
      _dailyForecast = forecasts['daily'];
    } catch (e) {
      _error = 'Failed to fetch forecast data';
    }
    notifyListeners();
  }
}