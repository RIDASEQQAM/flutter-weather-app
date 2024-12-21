import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast';
  
  Future<Map<String, dynamic>> getCurrentWeather() async {
    final response = await http.get(Uri.parse(
      '$baseUrl?latitude=52.52&longitude=13.41&current=temperature_2m,relative_humidity_2m&hourly=temperature_2m,relative_humidity_2m'
    ));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load current weather');
    }
  }

  Future<Map<String, dynamic>> getDailyForecast() async {
    final response = await http.get(Uri.parse(
      '$baseUrl?latitude=52.52&longitude=13.41&daily=temperature_2m_max,weathercode'
    ));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load daily forecast');
    }
  }

  String getWeatherDescription(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return 'Clear sky';
      case 1:
      case 2:
      case 3:
        return 'Partly cloudy';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rain';
      case 71:
      case 73:
      case 75:
        return 'Snow';
      case 95:
        return 'Thunderstorm';
      default:
        return 'Unknown';
    }
  }
}
