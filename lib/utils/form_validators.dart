class FormValidators {
  // التحقق من المعرف الأكاديمي أو البريد الإلكتروني
  static String? validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال المعرف الأكاديمي أو البريد الإلكتروني';
    }
    if (value.trim().length < 5) {
      return 'المعرف يجب ألا يقل عن 5 خانات';
    }
    return null;
  }

  // التحقق من كلمة المرور لتسجيل الدخول
  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 محارف على الأقل';
    }
    return null;
  }

  // التحقق من الاسم الكامل
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال الاسم الكامل';
    }
    if (value.trim().length < 3) {
      return 'الاسم الكامل يجب أن يكون 3 محارف على الأقل';
    }
    return null;
  }

  // التحقق من الرقم الأكاديمي (أرقام فقط، 9-10 خانات)
  static String? validateAcademicId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال الرقم الأكاديمي';
    }
    final regExp = RegExp(r'^\d{9,10}$');
    if (!regExp.hasMatch(value.trim())) {
      return 'الرقم الأكاديمي يجب أن يتكون من 9 إلى 10 أرقام حصراً';
    }
    return null;
  }

  // التحقق من البريد الجامعي عبر Regex
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegExp.hasMatch(value.trim())) {
      return 'يرجى إدخال بريد إلكتروني بصيغة صحيحة';
    }
    return null;
  }

  // سياسة أمان كلمة المرور القوية (≥ 8 محارف + رقم + حرف كبير)
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون 8 محارف على الأقل';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'يجب أن تحتوي كلمة المرور على حرف كبير (Uppercase) واحد على الأقل';
    }
    return null;
  }

  // التحقق من مطابقة تأكيد كلمة المرور
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }
    if (value != password) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }

  // التحقق من رمز OTP (6 أرقام حصراً)
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال رمز التحقق';
    }
    final otpRegExp = RegExp(r'^\d{6}$');
    if (!otpRegExp.hasMatch(value.trim())) {
      return 'رمز التحقق يجب أن يتكون من 6 أرقام حصراً';
    }
    return null;
  }
}