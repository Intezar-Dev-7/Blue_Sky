import 'package:blue_sky/model/weather_data_current.dart';
import 'package:blue_sky/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const CurrentWeatherWidget({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // temprature area
        tempratureAreaWidget(),
        const SizedBox(
          height: 20,
        ),
        // more details - windspped , humuidity & clouds
        currentWeatherMoreDetailsWideget(),
      ],
    );
  }

  currentWeatherMoreDetailsWideget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 55,
              width: 55,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icon/windspeed.png"),
            ),
            Container(
              height: 55,
              width: 55,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icon/clouds.png"),
            ),
            Container(
              height: 55,
              width: 55,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icon/humidity.png"),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.windSpeed}km/h",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.clouds}%",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.humidity}%",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }

  tempratureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/image/${weatherDataCurrent.current.weather![0].icon}.png",
          width: 70,
          height: 70,
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "${weatherDataCurrent.current.temp!.toInt()}°",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 68,
                    color: CustomColors.textColorBlack,
                  )),
              TextSpan(
                  text: "${weatherDataCurrent.current.weather![0].description}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
