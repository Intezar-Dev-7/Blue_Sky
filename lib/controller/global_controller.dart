import 'package:blue_sky/api/fetch_weather.dart';
import 'package:blue_sky/model/weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
// create various variables
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  final RxString _errorMessage = ''.obs;

  RxString getErrorMessage() => _errorMessage;
// instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;

  WeatherData getData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    _errorMessage.value = ''; // Clear error message

    // bool isServiceEnabled;

    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // return if service is not enabled
    if (!isServiceEnabled) {
      _errorMessage.value =
          'Location service is not enabled, Please enable it in the settings.';
      _isLoading.value = false;
      return;
    }

    // Status of location permission

    LocationPermission locationPermission;
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      _errorMessage.value = 'Location permission is denied forever';
      _isLoading.value = false;
      return;
    } else if (locationPermission == LocationPermission.denied) {
      // request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        _errorMessage.value = 'Location permission is denied';
        _isLoading.value = false;
        return;
      }

      // getting the cuurent location
      return await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        // Update the latitude and longitude
        _latitude.value = value.latitude;
        _longitude.value = value.longitude;
        // calling our weather api

        return FetchWeatherAPI()
            .processData(value.latitude, value.longitude)
            .then((value) {
          weatherData.value = value;
          _isLoading.value = false;
        });

        // print(_latitude.value);
        // print(_longitude.value);
      });
    }
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
