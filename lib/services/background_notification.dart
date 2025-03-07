import 'package:blue_sky/api/fetch_weather.dart';
import 'package:blue_sky/controller/global_controller.dart';
import 'package:blue_sky/services/notification_service.dart';

import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      // initialize Getx controller
      GlobalController globalController = Get.put(GlobalController());

      // wait for location to be fetched
      await globalController.getLocation();

      double lat = globalController.getLatitude().value;
      double lon = globalController.getLongitude().value;

      if (lat == 0.0 || lon == 0.0) {
        await NotificationService.showNotification(
            "Weather Update", " Failed to fetch weather data");
        return Future.value(false);
      }

      // fetch weather data using stored location
      var weatherData = await FetchWeatherAPI().processData(lat, lon);

// extract temperature and condition with null safety
      int temp = weatherData.current?.current.temp?.round() ?? 0;

      String condition = (weatherData.current?.current.weather != null &&
              weatherData.current!.current.weather!.isNotEmpty)
          ? weatherData.current!.current.weather![0].description ?? "Unknown"
          : "Unknown";
      String weatherInfo = "🌡 Temp: $temp°C\n🌤 Condition: $condition";

      //show Notification
      await NotificationService.showNotification("Weather Update", weatherInfo);
      return Future.value(true);
    } catch (e) {
      await NotificationService.showNotification(
          "Weather update", "Failed to fetch weather data.");
      return Future.value(false);
    }
  });
}
