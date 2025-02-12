import 'package:blue_sky/model/weather_data_daily.dart';
import 'package:blue_sky/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyDataForecastWidget extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyDataForecastWidget({super.key, required this.weatherDataDaily});

// String manipulation
  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Coming Days",
              style:
                  TextStyle(color: CustomColors.textColorBlack, fontSize: 17),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
          itemCount: weatherDataDaily.daily.length > 7
              ? 7
              : weatherDataDaily.daily.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          getDay(weatherDataDaily.daily[index].dt),
                          style: TextStyle(
                              color: CustomColors.textColorBlack, fontSize: 13),
                        ),
                      ),
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                              'assets/image/${weatherDataDaily.daily[index].weather![0].icon}.png')),
                      Text(
                          "${weatherDataDaily.daily[index].temp!.max}°C/ ${weatherDataDaily.daily[index].temp!.min}°C")
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: CustomColors.dividerLine,
                )
              ],
            );
          }),
    );
  }
}
