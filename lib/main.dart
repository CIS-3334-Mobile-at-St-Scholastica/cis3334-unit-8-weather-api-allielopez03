import 'package:flutter/material.dart';
import 'package:flutter_weatherapi_f25/Model/my_weather_model.dart';
import 'rest_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CIS 3334 Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<DailyForecast>> futureWeatherForecasts;

  @override
  void initState() {
    super.initState();
    futureWeatherForecasts = fetchWeather(); // fetch API data
  }

  // Function to return the correct weather icon
  Widget weatherImage(String condition) {
    final imageMap = {
      "Clear": 'graphics/sun.png',
      "Clouds": 'graphics/cloud.png',
      "Rain": 'graphics/rain.png',
    };
    return Image.asset(
      imageMap[condition] ?? 'graphics/sun.png',
      width: 50,
      height: 50,
    );
  }

  // Widget for each weather tile
  Widget weatherTile(DailyForecast weather) {
    return ListTile(
      leading: weatherImage(weather.main),
      title: Text("Temp: ${weather.temp}°F"),
      subtitle: Text("Condition: ${weather.main}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<DailyForecast>>(
        future: futureWeatherForecasts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No weather data available'));
          }

          final weatherList = snapshot.data!;
          return ListView.builder(
            itemCount: weatherList.length,
            itemBuilder: (BuildContext context, int index) {
              final weather = weatherList[index];
              return Card(child: weatherTile(weather));
            },
          );
        },
      ),
    );
  }
}
