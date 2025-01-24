// Defining the Structure of the weather data

class Weather {
  final String city;
  final String description;
  final double temperature;
  final double humidity;
  final double windSpeed;

  Weather({
    required this.city,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}
