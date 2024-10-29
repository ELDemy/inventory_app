import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/di/injector.dart';
import 'package:inventory_app/features/user_management/data/user_model.dart';
import 'package:meta/meta.dart';

part 'user_management_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitial()) {
    getUsers();
  }

  final List<UserModel> users = [];
  Future<void> getUsers() async {
    try {
      emit(UserManagementLoading());
      users.clear();

      QuerySnapshot<Map<String, dynamic>> usersDocs =
          await Injector.usersCollection.get();
      print(usersDocs);
      if (usersDocs.docs.isNotEmpty) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc
            in usersDocs.docs) {
          users.add(UserModel.fromFirestore(doc.data()));
        }
      }
      emit(UserManagementSuccess());
    } on FirebaseException catch (firebaseException) {
      log('Error creating document: ${firebaseException.message}');
      return emit(UserSignUpFailure(
          FirebaseFailure.fromFirebaseException(firebaseException).errMsg));
    } catch (e) {
      log('An unexpected error occurred: $e');
      return emit(UserManagementFailure("حدث خطأ برجاء المحاوله مره اخري!!"));
    }
  }

  Future<void> deleteUser(String email) async {
    try {
      emit(UserManagementLoading());
      print(email);
      await Injector.usersCollection.doc(email).delete();
      print("ELDEMY:: deleted doc");
      users.removeWhere((user) => user.email == email);
      await getUsers();
      emit(UserManagementSuccess());
    } on FirebaseException catch (firebaseException) {
      log('Error deleting user: ${firebaseException.message}');
      emit(UserManagementFailure(
          FirebaseFailure.fromFirebaseException(firebaseException).errMsg));
    } catch (e) {
      log('An unexpected error occurred: $e');
      emit(UserManagementFailure("حدث خطأ برجاء المحاوله مره اخري!!"));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      emit(UserSignUpLoading());

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _addUserDoc(email, name, password);

      emit(UserSignUpSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'حدث خطأ ما';
      if (e.code == 'email-already-in-use') {
        await _addUserDoc(email, name, password);
        errorMessage = 'تم الاضافه الى قاعدة البيانات مرة اخرى';
        return emit(UserSignUpSuccess());
      } else if (e.code == 'weak-password') {
        errorMessage = 'كلمة المرور ضعيفة جدًا';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'يرجى إدخال بريد إلكتروني صحيح';
      }
      emit(UserSignUpFailure(errorMessage));
    } catch (e) {
      emit(UserSignUpFailure('حدث خطأ غير متوقع'));
    }
  }

  Future<void> _addUserDoc(String email, String name, String password) async {
    await Injector.usersCollection.doc(email).set(
      {
        'name': name,
        'email': email,
        'password': password,
        'role': "موظف",
        'createdAt': Timestamp.now(),
      },
    );
    await getUsers();
  }
}
