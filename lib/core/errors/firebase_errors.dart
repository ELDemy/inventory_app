import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/errors/abstract_failure_class.dart';

class FirebaseFailure extends Failure {
  FirebaseFailure(super.errMsg);

  // Factory constructor to handle FirebaseException and return appropriate error message
  factory FirebaseFailure.fromFirebaseException(FirebaseException e) {
    return FirebaseFailure(_handleFirebaseException(e));
  }

  static String _handleFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'ليس لديك إذن لإجراء هذا الإجراء.';
      case 'network-error':
        return 'حدث خطأ في الشبكة. يرجى التحقق من الاتصال.';
      case 'unavailable':
        return 'حدث خطأ في الوصول الى الخادم يرجى اعادة المحاولة';
      case 'not-found':
        return 'الوثيقة المطلوبة غير موجودة.';
      case 'already-exists':
        return 'المنتج موجود بالفعل. يرجى التحقق من الرقم التسلسلي.';
      case 'invalid-argument':
        return 'تم تقديم بيانات غير صحيحة. يرجى التحقق من الإدخال.';
      case 'cancelled':
        return 'تم إلغاء العملية.';
      case 'deadline-exceeded':
        return 'انتهت المهلة الزمنية للعملية. حاول مرة أخرى.';
      default:
        return 'حدث خطأ غير متوقع: ${e.message}';
    }
  }
}
