import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/di/auth_service.dart';
import 'package:inventory_app/super_admin.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  @override
  Future<void> close() {
    _authService.dispose();
    return super.close();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = GetIt.I.get<AuthService>();

  // Check initial auth state
  Future<bool> checkInitialAuthState(BuildContext context) async {
    try {
      final User? currentUser = _auth.currentUser;

      // Super Admin OverRide
      if (SuperAdmin.isSuperAdmin()) return true;

      if (currentUser?.email == null) {
        return false;
      } else {
        final bool userExists =
            await _authService.checkUserInFirestore(currentUser!.email!);

        if (userExists) {
          _authService.setupUserListener(context, currentUser.email!);
          return true;
        } else {
          await _authService.signOut();
          return false;
        }
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

      // Super Admin override
      if (SuperAdmin.isSuperAdmin()) {
        return emit(AuthSuccess());
      }

      final bool userExists = await _authService.checkUserInFirestore(email);

      if (!userExists) {
        emit(AuthError('هذا المستخدم غير مسجل في النظام'));
      } else {
        _authService.setupUserListener(context, userCredential.user!.email!);
        emit(AuthSuccess());
      }
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException signIn function authCubit : ${e.toString()}");
      emit(AuthError(FirebaseFailure.fromFirebaseAuthException(e).errMsg));
    } on FirebaseException catch (e) {
      log('Error fetching documents: ${e.message}');
      return emit(AuthError(FirebaseFailure.fromFirebaseException(e).errMsg));
    } catch (e) {
      log("Error at Home Cubit: ${e}");
      return emit(AuthError("حدث خطأ يرجى اعادة المحاولة!!"));
    }
  }
}
