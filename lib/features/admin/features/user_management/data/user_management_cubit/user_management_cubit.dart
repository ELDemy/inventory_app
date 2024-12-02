import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inventory_app/core/errors/abstract_failure_class.dart';
import 'package:inventory_app/core/errors/firebase_errors.dart';
import 'package:inventory_app/core/models/user_model.dart';
import 'package:inventory_app/di/injector.dart';
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

      if (usersDocs.docs.isNotEmpty) {
        for (var doc in usersDocs.docs) {
          users.add(UserModel.fromFirestore(doc.data()));
        }
      }
      emit(UserManagementSuccess());
    } on FirebaseException catch (firebaseException) {
      return emit(UserSignUpFailure(
          FirebaseFailure.fromFirebaseException(firebaseException).errMsg));
    } catch (e) {
      Failure.exception(e);
      return emit(UserManagementFailure("حدث خطأ برجاء المحاوله مره اخري!!"));
    }
  }

  Future<void> deleteUser(String email) async {
    try {
      emit(UserManagementLoading());
      await Injector.usersCollection.doc(email).delete();
      await getUsers();
      emit(UserManagementSuccess());
    } on FirebaseException catch (firebaseException) {
      emit(UserManagementFailure(
          FirebaseFailure.fromFirebaseException(firebaseException).errMsg));
    } catch (e) {
      Failure.exception(e);
      emit(UserManagementFailure("حدث خطأ برجاء المحاوله مره اخري!!"));
    }
  }

  Future<void> signUp({
    required UserModel userModel,
  }) async {
    try {
      emit(UserSignUpLoading());

      // to not change the current user credentials

      await Firebase.initializeApp(
          name: 'admin-app', options: Firebase.app().options);
      await FirebaseAuth.instanceFor(app: Firebase.app('admin-app'))
          .createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      await _addUserDoc(userModel);
      emit(UserSignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        await _addUserDoc(userModel);
        emit(UserSignUpSuccess());
        return emit(UserSignUpFailure(
            "البريد الالكتروني مسجل سابقا!! يجب استخدام الباسوورد القديم"));
      }
      emit(UserSignUpFailure(
        FirebaseFailure.fromFirebaseAuthException(e).errMsg,
      ));
    } on FirebaseException catch (firebaseException) {
      emit(UserSignUpFailure(
          FirebaseFailure.fromFirebaseException(firebaseException).errMsg));
    } catch (e) {
      Failure.exception(e);
      emit(UserSignUpFailure('حدث خطأ برجاء المحاوله مره اخري!!'));
    } finally {
      // Clean up by deleting the secondary app
      try {
        await Firebase.app('admin-app').delete();
      } catch (e) {
        Failure.exception(e);
        print('Error deleting admin app: $e');
      }
    }
  }

  Future<void> _addUserDoc(UserModel userModel) async {
    await Injector.usersCollection.doc(userModel.email).set(
          userModel.toFireStore(),
        );
    await getUsers();
  }
}
