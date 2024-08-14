import 'package:cloud_firestore/cloud_firestore.dart';

class LoginModel {
  String email;
  String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return LoginModel(
      email: data['email'] ?? '',
      password: data['password'] ?? '',
    );
  }
}
