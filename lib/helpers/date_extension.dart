import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get DayDate {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
