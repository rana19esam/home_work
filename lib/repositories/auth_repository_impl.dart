import 'dart:async';
import '../models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel> login(LoginRequest request) async {
    // محاكاة استجابة الشبكة (تأخير ثانبتين)
    await Future.delayed(const Duration(seconds: 2));

    if (request.password == "Wrong123") {
      throw Exception("بيانات الدخول غير صحيحة، يرجى التأكد وإعادة المحاولة.");
    }

    return UserModel(
      id: "USR-9982",
      fullName: "طالب نموذجي",
      academicId: "441001234",
      email: request.identifier.contains('@')
          ? request.identifier
          : "student@university.edu.sa",
    );
  }

  @override
  Future<bool> register(RegisterRequest request) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<bool> sendPasswordResetCode(String identifier) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<bool> resetPassword({
    required String otp,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}