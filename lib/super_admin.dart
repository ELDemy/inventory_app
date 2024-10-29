import 'package:firebase_auth/firebase_auth.dart';

class SuperAdmin {
  static bool isSuperAdmin() {
    return FirebaseAuth.instance.currentUser?.email ==
        "mahmoudeldemerdash5@gmail.com";
  }
}
