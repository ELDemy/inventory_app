import 'package:intl/intl.dart';

extension MyDateExtension on DateTime {
  String dayFormat() {
    return DateFormat("yyy-M-dd").format(this);
  }
}
