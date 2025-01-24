// Manages the state and business logic of the weather app

import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/api.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherApi _weatherApi = WeatherApi();
  Weather? _weather;
  bool _isLoading = false;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherApi.fetchWeather(city);
    } catch (e) {
      _weather = null;
      debugPrint('Error fetching weather: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
