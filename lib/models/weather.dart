class Weather {
  final double temperature;
  final String description;
  final String icon;
  final double windSpeed;
  final int humidity;
  final double uvIndex;
  final DateTime sunrise;
  final DateTime sunset;
  final String location;

  Weather({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
    required this.uvIndex,
    required this.sunrise,
    required this.sunset,
    required this.location,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      windSpeed: json['wind']['speed'].toDouble(),
      humidity: json['main']['humidity'],
      uvIndex: 0.0, // This would come from a separate API call
      sunrise: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
      location: json['name'],
    );
  }
}