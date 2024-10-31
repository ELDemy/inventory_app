import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final DateTime createdAt;
  final String password;
  final String role;
  final String name;
  final String email;

  UserModel({
    required this.createdAt,
    required this.password,
    required this.role,
    required this.name,
    required this.email,
  });

  // Factory constructor to create a UserModel from Firestore data
  factory UserModel.fromFirestore(Map<String, dynamic>? data) {
    return UserModel(
      createdAt: data?['createdAt'] != null
          ? (data?['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      password: data?['password'] ?? '',
      role: data?['role'] ?? '',
      name: data?['name'] ?? '',
      email: data?['email'] ?? '',
    );
  }

  // Convert the model to a map to save it back to Firestore
  Map<String, dynamic> toMap() {
    return {
      'createdAt': Timestamp.fromDate(createdAt),
      'password': password,
      'role': role,
      'name': name,
      'email': email,
    };
  }
}
