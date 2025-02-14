import 'package:blue_sky/model/sunrise_sunset.dart';
import 'package:blue_sky/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SunsetAndSunrise extends StatelessWidget {
  final SunriseSunsetModel sunriseAndSunset;

  const SunsetAndSunrise({super.key, required this.sunriseAndSunset});

  // Method to format time in "hh:mm AM/PM" format
  String formatTime(int? timestamp) {
    if (timestamp == null || timestamp <= 0) return "N/A"; // Extra safeguard

    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat.jm()
        .format(time); // Uses "h:mm a" format (e.g., "6:30 PM")
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Header
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Sunrise & Sunset Times',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.textColorBlack,
                  ),
            ),
          ),
          Container(height: 1, color: CustomColors.dividerLine),
          const SizedBox(height: 20),

          // Sunrise Section
          _buildTimeRow(
            context,
            title: 'Sunrise:',
            time: formatTime(sunriseAndSunset.sunrise),
          ),

          const SizedBox(height: 10),

          // Sunset Section
          _buildTimeRow(
            context,
            title: 'Sunset:',
            time: formatTime(sunriseAndSunset.sunset),
          ),

          const SizedBox(height: 20),
          Container(height: 1, color: CustomColors.dividerLine),
        ],
      ),
    );
  }

  Widget _buildTimeRow(BuildContext context,
      {required String title, required String time}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: CustomColors.textColorBlack,
                ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: CustomColors.textColorBlack,
                ),
          ),
        ],
      ),
    );
  }
}
