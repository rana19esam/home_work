// نموذج بيانات المستخدم
class UserModel {
  final String id;
  final String fullName;
  final String academicId;
  final String email;

  UserModel({
    required this.id,
    required this.fullName,
    required this.academicId,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      academicId: json['academicId'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'academicId': academicId,
      'email': email,
    };
  }
}

// نموذج طلب تسجيل الدخول
class LoginRequest {
  final String identifier; // البريد أو الرقم الأكاديمي
  final String password;
  final bool rememberMe;

  LoginRequest({
    required this.identifier,
    required this.password,
    this.rememberMe = false,
  });
}

// نموذج طلب إنشاء حساب
class RegisterRequest {
  final String fullName;
  final String academicId;
  final String email;
  final String password;
  final bool acceptedTerms;

  RegisterRequest({
    required this.fullName,
    required this.academicId,
    required this.email,
    required this.password,
    required this.acceptedTerms,
  });
}