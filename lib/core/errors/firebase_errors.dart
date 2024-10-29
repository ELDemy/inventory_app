import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app/core/errors/abstract_failure_class.dart';

class FirebaseFailure extends Failure {
  FirebaseFailure(super.errMsg);

  factory FirebaseFailure.fromFirebaseException(FirebaseException e) {
    return FirebaseFailure(_handleFirebaseException(e));
  }

  factory FirebaseFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    return FirebaseFailure(_handleAuthException(e));
  }

  static String _handleFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'network-request-failed':
        return 'خطأ في الشبكة. يرجى التحقق من الاتصال.';
      case 'permission-denied':
        return 'ليس لديك صلاحيه';
      case 'not-found':
        return 'المورد المطلوب غير موجود.';
      case 'unavailable':
        return 'الخدمة غير متاحة حاليا. حاول مرة أخرى لاحقًا.';
      case 'already-exists':
        return 'المورد الذي تحاول إضافته موجود بالفعل.';
      case 'cancelled':
        return 'تم إلغاء العملية.';
      case 'data-loss':
        return 'حدث فقدان في البيانات.';
      case 'deadline-exceeded':
        return 'الوقت المحدد للعملية قد انتهى.';
      case 'invalid-argument':
        return 'تم إدخال بيانات غير صحيحة.';
      case 'unauthenticated':
        return 'يرجى تسجيل الدخول للوصول إلى هذا المورد.';
      default:
        return 'حدث خطأ غير متوقع: ${e.message}';
    }
  }

  // Private static method to handle various FirebaseAuthException codes
  static String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'البريد الإلكتروني موجود بالفعل.';
      case 'user-not-found':
        return 'لم يتم العثور على حساب بهذا البريد الإلكتروني.';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة. يرجى المحاولة مرة أخرى.';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جدًا. يرجى اختيار كلمة مرور أقوى.';
      case 'invalid-email':
        return 'يرجى إدخال بريد إلكتروني صحيح.';
      case 'user-disabled':
        return 'تم تعطيل هذا الحساب. يرجى الاتصال بالدعم.';
      case 'operation-not-allowed':
        return 'تم تعطيل تسجيل الدخول باستخدام هذه الوسيلة. يرجى الاتصال بالدعم.';
      case 'network-request-failed':
        return 'خطأ في الشبكة. يرجى التحقق من الاتصال.';
      case 'too-many-requests':
        return 'تم إرسال الكثير من الطلبات. يرجى الانتظار قليلاً والمحاولة مرة أخرى.';
      default:
        return 'حدث خطأ غير متوقع: ${e.message}';
    }
  }
}
