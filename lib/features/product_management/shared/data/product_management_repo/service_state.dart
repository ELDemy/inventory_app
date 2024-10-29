import 'package:firebase_core/firebase_core.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';

class ServiceState {
  final String serviceStateMsg;
  ServiceState({required this.serviceStateMsg});

  factory ServiceState.exceptionError() {
    return ServiceState(serviceStateMsg: "حدث خطأ برجاء المحاوله مره اخري!!");
  }
  factory ServiceState.serviceError() {
    return ServiceState(serviceStateMsg: "حدث خطأ برجاء اعادة المحاوله!!");
  }
  factory ServiceState.firebaseException(FirebaseException firebaseException) {
    return ServiceState(
        serviceStateMsg:
            FirebaseFailure.fromFirebaseException(firebaseException).errMsg);
  }
}
