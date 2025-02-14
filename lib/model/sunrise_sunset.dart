class SunriseSunsetModel {
  final int? sunrise;
  final int? sunset;

  SunriseSunsetModel({this.sunrise, this.sunset});

  // Factory constructor to create an instance from JSON
  factory SunriseSunsetModel.fromJson(Map<String, dynamic> json) {
    final currentData = json['current'] as Map<String, dynamic>?;

    // print("Raw JSON: $json");
    // print("Parsed Sunrise: ${currentData?['sunrise']}");
    // print("Parsed Sunset: ${currentData?['sunset']}");

    return SunriseSunsetModel(
      sunrise: currentData?['sunrise'] as int?,
      sunset: currentData?['sunset'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}
