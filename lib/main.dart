import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'repositories/auth_repository_impl.dart';
import 'views/auth/login_page.dart';

void main() {
  runApp(const StudentAuthApp());
}

class StudentAuthApp extends StatelessWidget {
  const StudentAuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    // إنشاء كائن المستودع والمتحكم
    final authRepository = AuthRepositoryImpl();
    final authController = AuthController(repository: authRepository);

    return MaterialApp(
      title: 'نظام المصادقة الطلابي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      // دعم اتجاه النص من اليمين إلى اليسار للغة العربية
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: LoginPage(controller: authController),
      ),
    );
  }
}