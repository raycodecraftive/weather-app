import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_models/weather_view_model.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();
  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    viewModel.fetchWeather(_cityController.text);
                  },
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (viewModel.isLoading)
              const CircularProgressIndicator()
            else if (viewModel.weather != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.weather!.city,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    viewModel.weather!.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text('Temperature: ${viewModel.weather!.temperature}°C'),
                  Text('Humidity: ${viewModel.weather!.humidity}%'),
                  Text('Wind Speed: ${viewModel.weather!.windSpeed} m/s'),
                ],
              )
            else
              const Text('Enter a city to see the weather'),
          ],
        ),
      ),
    );
  }
}
