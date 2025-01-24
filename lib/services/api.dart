import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherApi {
  final String baseUrl = 'https://api.tomorrow.io/v4/timelines';
  final String apiKey =
      'https://api.meteomatics.com/2024-07-05T12:00:00Z/t_2m:C/47.3769,8.5417/json?apikey=x4dYRqLdSAx6hWMOVrtrmgAGg3UpNz2k'; // Replace with your API key

  Future<Weather> fetchWeather(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Weather.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
