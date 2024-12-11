import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'product_model.dart';

class PowerUtils {
  /// Parse power string to a numeric value in kilowatts
  static double parsePower(String? powerStr) {
    if (powerStr == null || powerStr.isEmpty) return 0.0;
    // Normalize the input string
    powerStr = powerStr.toLowerCase().trim().replaceAll(' ', '');

    // Mapping of units to their conversion factors to kilowatts
    final Map<String, double> units = {
      'kw': 1.0, // kilowatts
      'mw': 1000.0, // megawatts to kilowatts
      'w': 0.001, // watts to kilowatts
    };

    try {
      // Check each unit
      for (var unit in units.keys) {
        if (powerStr.endsWith(unit)) {
          // Remove the unit and parse the numeric value
          String numericPart =
              powerStr.substring(0, powerStr.length - unit.length);
          return double.parse(numericPart) * units[unit]!;
        }
      }

      // If no unit found, assume it's already in kilowatts
      return double.parse(powerStr);
    } catch (e) {
      // Handle parsing errors
      FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: 'Error parsing power: $powerStr',
      );
      // print('Error parsing power: $powerStr');
      return 0.0;
    }
  }

  /// Sort products by power
  static List<ProductModel> sortProductsByPower(List<ProductModel> products) {
    return products.toList()
      ..sort(
        (a, b) {
          // print('A: ${parsePower(a.power)}, B: ${parsePower(b.power)}');
          return parsePower(b.power).compareTo(parsePower(a.power));
        },
      );
  }
}
