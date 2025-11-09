// my_weather_model.dart

class DailyForecast {
  final double temp;         // temperature
  final String main;         // main weather description (Clear, Clouds, Rain)
  final String description;  // detailed description

  DailyForecast({
    required this.temp,
    required this.main,
    required this.description,
  });

  // Convert JSON from a single forecast (one element in 'list') into this class
  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      temp: (json['main']['temp'] as num).toDouble(),
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
    );
  }

  // Optional: convert back to JSON if needed
  Map<String, dynamic> toJson() => {
    'temp': temp,
    'main': main,
    'description': description,
  };
}

