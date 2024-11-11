import 'package:firebase_analytics/firebase_analytics.dart';

abstract class Failure {
  final String errMsg;

  static void exception(e) {
    FirebaseAnalytics.instance
        .logEvent(name: "exception", parameters: {"exception": e.toString()});
  }

  Failure(this.errMsg);
}
