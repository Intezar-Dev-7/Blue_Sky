import 'package:blue_sky/api/api_key.dart';

String apiURL(var lat, var lon) {
  String url =
      'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely';
  return url;
}
