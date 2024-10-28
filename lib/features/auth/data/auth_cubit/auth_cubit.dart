import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/auth/data/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthInitial());

  // Check initial auth state
  Future<bool> checkInitialAuthState(BuildContext context) async {
    try {
      final User? currentUser = _auth.currentUser;

      if (currentUser?.email != null) {
        final bool userExists =
            await _authService.checkUserInFirestore(currentUser!.email!);

        if (userExists) {
          _authService.setupUserListener(currentUser.email!, context);
          return true;
        } else {
          await _authService.logout();
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoading());

      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      final bool userExists = await _authService.checkUserInFirestore(email);

      if (!userExists) {
        emit(AuthError('هذا المستخدم غير مسجل في النظام'));
        return;
      } else {
        _authService.setupUserListener(userCredential.user!.email!, context);

        emit(AuthSuccess());
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'حدث خطأ ما';

      if (e.code == 'user-not-found') {
        errorMessage = 'لم يتم العثور على مستخدم لهذا البريد الإلكتروني';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'اسم المستخدم او كلمة السر غير صحيحه';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'كلمة المرور التي تم إدخالها غير صحيحة';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'يرجى إدخال بريد إلكتروني صالح';
      }

      emit(AuthError(errorMessage));
    } catch (e) {
      print(e);
      emit(AuthError('حدث خطأ غير متوقع'));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      emit(AuthLoading());

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Injector.usersCollection.doc(userCredential.user!.email).set(
        {
          'name': name,
          'email': email,
          'password': password,
          'role': "موظف",
          'createdAt': Timestamp.now(),
        },
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'حدث خطأ ما';

      if (e.code == 'weak-password') {
        errorMessage = 'كلمة المرور ضعيفة جدًا';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'يوجد حساب مسجل بالفعل بهذا البريد الإلكتروني';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'يرجى إدخال بريد إلكتروني صحيح';
      }
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<void> close() {
    _authService.dispose();
    return super.close();
  }
}
