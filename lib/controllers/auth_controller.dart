import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository _repository;

  AuthController({required AuthRepository repository})
      : _repository = repository;

  // حالات التحكم
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // حالة إخفاء/إظهار كلمة المرور
  bool _isObscuredLogin = true;
  bool get isObscuredLogin => _isObscuredLogin;

  bool _isObscuredRegister = true;
  bool get isObscuredRegister => _isObscuredRegister;

  bool _isObscuredConfirm = true;
  bool get isObscuredConfirm => _isObscuredConfirm;

  // حالة تذكرني والموافقة على الشروط
  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  bool _acceptedTerms = false;
  bool get acceptedTerms => _acceptedTerms;

  // التبديل بين الحالات
  void toggleObscureLogin() {
    _isObscuredLogin = !_isObscuredLogin;
    notifyListeners();
  }

  void toggleObscureRegister() {
    _isObscuredRegister = !_isObscuredRegister;
    notifyListeners();
  }

  void toggleObscureConfirm() {
    _isObscuredConfirm = !_isObscuredConfirm;
    notifyListeners();
  }

  void setRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  void setAcceptedTerms(bool? value) {
    _acceptedTerms = value ?? false;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // العمليات البرمجية
  Future<bool> login(String identifier, String password) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final request = LoginRequest(
        identifier: identifier,
        password: password,
        rememberMe: _rememberMe,
      );
      _currentUser = await _repository.login(request);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
      _setLoading(false);
      return false;
    }
  }

  Future<bool> register({
    required String fullName,
    required String academicId,
    required String email,
    required String password,
  }) async {
    if (!_acceptedTerms) {
      _errorMessage = "يجب الموافقة على اللوائح والشروط الأكاديمية للمتابعة";
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      final request = RegisterRequest(
        fullName: fullName,
        academicId: academicId,
        email: email,
        password: password,
        acceptedTerms: _acceptedTerms,
      );
      final success = await _repository.register(request);
      _setLoading(false);
      return success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
      _setLoading(false);
      return false;
    }
  }

  Future<bool> sendPasswordResetCode(String identifier) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final success = await _repository.sendPasswordResetCode(identifier);
      _setLoading(false);
      return success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
      _setLoading(false);
      return false;
    }
  }

  Future<bool> resetPassword({
    required String otp,
    required String newPassword,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final success = await _repository.resetPassword(
        otp: otp,
        newPassword: newPassword,
      );
      _setLoading(false);
      return success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
      _setLoading(false);
      return false;
    }
  }
}