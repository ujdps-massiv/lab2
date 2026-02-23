import 'dart:async';

/// ===============================
/// PART 1 — Future & async/await
/// ===============================

// Fetch current weather
Future<String> fetchCurrentWeather() async {
  print('Fetching current weather...');
  await Future.delayed(Duration(seconds: 2));
  return 'Sunny';
}

// Fetch temperature
Future<int> fetchTemperature() async {
  await Future.delayed(Duration(seconds: 1));
  return 28;
}

// Fetch humidity
Future<int> fetchHumidity() async {
  await Future.delayed(Duration(seconds: 1));
  return 65;
}

/// ===============================
/// PART 2 — Parallel Loading
/// ===============================

Future<void> displayWeatherReport() async {
  print('\n=== Weather Report ===\n');

  try {
    // Fetch weather first
    String weather = await fetchCurrentWeather();

    // Fetch temperature & humidity in parallel
    var results = await Future.wait([
      fetchTemperature(),
      fetchHumidity(),
    ]);

    int temperature = results[0];
    int humidity = results[1];

    print('Current Weather: $weather');
    print('Temperature: ${temperature}°C');
    print('Humidity: $humidity%');
    print('\n========================');
  } catch (e) {
    print('Error fetching weather report: $e');
  }
}

/// ===============================
/// PART 3 — Stream Forecast
/// ===============================

Stream<String> forecastStream() async* {
  var forecasts = [
    'Partly Cloudy',
    'Rainy',
    'Sunny',
    'Cloudy',
    'Sunny',
  ];

  for (var forecast in forecasts) {
    await Future.delayed(Duration(seconds: 1));
    yield forecast;
  }
}

/// ===============================
/// MAIN FUNCTION
/// ===============================

Future<void> main() async {
  print('=== Weather App ===\n');

  try {
    await displayWeatherReport();

    print('\n=== 5-Day Forecast ===\n');

    int day = 1;

    await for (String forecast in forecastStream()) {
      DateTime date = DateTime.now().add(Duration(days: day - 1));

      String formattedDate =
          "${date.day}/${date.month}/${date.year}";

      print('Day $day ($formattedDate): $forecast');
      day++;
    }

    print('\nForecast complete!');
    print('Weather app completed!');
  } catch (e) {
    print('Something went wrong: $e');
  }
}