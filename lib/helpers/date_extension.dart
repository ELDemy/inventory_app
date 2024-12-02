import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get dayDate {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  DateTime get startOfDay {
    return DateTime(year, month, day, 0, 0, 0);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59);
  }
}
