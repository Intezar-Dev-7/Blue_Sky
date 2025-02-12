import 'package:blue_sky/controller/global_controller.dart';
import 'package:blue_sky/utils/custom_colors.dart';
import 'package:blue_sky/widgets/comfort_level.dart';
import 'package:blue_sky/widgets/current_weather_widget.dart';
import 'package:blue_sky/widgets/daily_data_forecast.dart';
import 'package:blue_sky/widgets/header_widget.dart';
import 'package:blue_sky/widgets/hourly_data_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? Center(
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
                ))
              : Center(
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
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
