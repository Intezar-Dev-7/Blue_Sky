import 'package:blue_sky/model/sunrise_sunset.dart';
import 'package:blue_sky/model/weather_data_current.dart';
import 'package:blue_sky/model/weather_data_daily.dart';
import 'package:blue_sky/model/weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;
  final SunriseSunsetModel? sunriseAndSunset;

  WeatherData([
    this.sunriseAndSunset,
    this.current,
    this.hourly,
    this.daily,
  ]);

  // function to fetch these values
  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
  SunriseSunsetModel getSunsetAndSunrise() => sunriseAndSunset!;
}
