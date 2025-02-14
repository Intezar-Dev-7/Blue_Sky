import 'package:blue_sky/controller/global_controller.dart';
import 'package:blue_sky/utils/custom_colors.dart';
import 'package:blue_sky/widgets/comfort_level.dart';
import 'package:blue_sky/widgets/current_weather_widget.dart';
import 'package:blue_sky/widgets/daily_data_forecast.dart';

import 'package:blue_sky/widgets/header_widget.dart';
import 'package:blue_sky/widgets/hourly_data_widget.dart';
import 'package:blue_sky/widgets/sunset_and_sunrise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  // Variable to manage dialog state (for loading indication)
  bool _isRetrying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            if (globalController.checkLoading().isTrue) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon/clouds.png',
                    height: 200,
                    width: 200,
                  ),
                  const CircularProgressIndicator()
                ],
              ));
            }

            if (globalController.getErrorMessage().isNotEmpty) {
              // Ensure the dialog is shown after the UI is built
              WidgetsBinding.instance.addPostFrameCallback((_) {
                debugPrint(
                    'Error: ${globalController.getErrorMessage().value}');
                showMyDialog(context);
              });
            }

            // Safely check if the weatherData is available
            final weatherData = globalController.getData();
            if (weatherData.current == null ||
                weatherData.hourly == null ||
                weatherData.daily == null) {
              return Center(child: Text('Weather data is unavailable.'));
            }
            return Center(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(height: 20),
                  HeaderWidget(),
                  // Current temp
                  CurrentWeatherWidget(
                    weatherDataCurrent:
                        globalController.getData().getCurrentWeather(),
                  ),
                  const SizedBox(height: 20),
                  HourlyDataWidget(
                    weatherDataHourly:
                        globalController.getData().getHourlyWeather(),
                  ),
                  const SizedBox(height: 20),

                  DailyDataForecastWidget(
                    weatherDataDaily:
                        globalController.getData().getDailyWeather(),
                  ),
                  Container(
                    height: 1,
                    color: CustomColors.dividerLine,
                  ),
                  const SizedBox(height: 15),
                  ComfortLevelWidget(
                      weatherDataCurrent:
                          globalController.getData().getCurrentWeather()),
                  const SizedBox(height: 15),
                  Container(
                    height: 1,
                    color: CustomColors.dividerLine,
                  ),
                  SunsetAndSunrise(
                    sunriseAndSunset:
                        globalController.getData().getSunsetAndSunrise(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(globalController.getErrorMessage().value),
                // display loading indicator if retry pressed
                if (_isRetrying)
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Retry'),
              onPressed: () async {
                setState(() {
                  _isRetrying = true;
                });

                // retry to fetch data
                await globalController.getLocation();

                setState(() {
                  _isRetrying = false; // Hide loading indicator after retry
                });

                // Close the dialog when retry is successful
                if (globalController.getErrorMessage().isEmpty) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
