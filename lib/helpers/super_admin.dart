import 'package:firebase_auth/firebase_auth.dart';

import '../di/injector.dart';

abstract class SuperAdmin {
  static bool isSuperAdmin() {
    return FirebaseAuth.instance.currentUser?.email ==
        "mahmoudeldemerdash5@gmail.com";
  }

  static bool isAdmin() {
    return Injector.activeUser?.role == "مدير" || isSuperAdmin();
  }
}
