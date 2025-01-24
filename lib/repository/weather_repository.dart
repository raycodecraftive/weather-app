import 'package:weather_app/services/api.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final ApiService _apiService =
      ApiService(baseUrl: "https://api.meteomatics.com");

  final String apiKey = "x4dYRqLdSAx6hWMOVrtrmgAGg3UpNz2k";

  Future<Weather> fetchWeather(String city) async {
    final response = await _apiService.sendRequest(
        method: HttpMethod.GET,
        url: "/2024-07-05T12:00:00Z/t_2m:C/47.3769,8.5417/json?apikey=$apiKey");

    return Weather.fromJson(response);
  }
}
