import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Model/my_weather_model.dart';

Future<List<DailyForecast>> fetchWeather() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=duluth&units=imperial&cnt=8&appid=5aa6c40803fbb300fe98c6728bdafce7'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return (jsonData['list'] as List)
        .map((item) => DailyForecast.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load weather');
  }
}
