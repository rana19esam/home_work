import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/student_model.dart'; // حسب مسار ملف الموديل لديك

class AttendanceController extends GetxController {
  // قائمة الطلاب الأصلية (معرفّة كـ Observable باستخدام .obs)
  final RxList<Student> _students = <Student>[
    Student(id: '1', name: 'أحمد محمود', avatarUrl: 'https://i.pravatar.cc/150?img=11'),
    Student(id: '2', name: 'سارة خالد', avatarUrl: 'https://i.pravatar.cc/150?img=5'),
    Student(id: '3', name: 'محمد علي', avatarUrl: 'https://i.pravatar.cc/150?img=12'),
    Student(id: '4', name: 'نورة الفهد', avatarUrl: 'https://i.pravatar.cc/150?img=9'),
    Student(id: '5', name: 'عمر القحطاني', avatarUrl: 'https://i.pravatar.cc/150?img=13'),
  ].obs;

  // نص البحث الحالي
  final RxString searchQuery = ''.obs;

  // قائمة الطلاب المفلترين بناءً على حقل البحث
  List<Student> get filteredStudents {
    if (searchQuery.isEmpty) return _students;
    return _students
        .where((s) => s.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  // حساب الإحصائيات
  int get totalStudents => _students.length;
  int get presentCount => _students.where((s) => s.isPresent).length;
  int get absentCount => totalStudents - presentCount;

  // تغيير حالة الحضور لطالب معين مع إظهار SnackBar
  void toggleAttendance(String id) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index != -1) {
      final currentStatus = _students[index].isPresent;
      _students[index].isPresent = !currentStatus;
      _students.refresh(); // إجبار GetX على تحديث الواجهة

      final studentName = _students[index].name;
      final newStatusText = !currentStatus ? 'حاضر' : 'غائب';
      final color = !currentStatus ? Colors.green : Colors.red;

      // إظهار تنبيه SnackBar عبر GetX بدون الحاجة لـ Context
      Get.rawSnackbar(
        message: 'تم تغيير حالة $studentName إلى: $newStatusText',
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }
  }

  // تحضير جميع الطلاب
  void markAllPresent() {
    for (var s in _students) {
      s.isPresent = true;
    }
    _students.refresh();
    Get.rawSnackbar(
      message: 'تم تحضير جميع الطلاب بنجاح',
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // تصفير سجل الحضور للجميع
  void resetAll() {
    for (var s in _students) {
      s.isPresent = false;
    }
    _students.refresh();
    Get.rawSnackbar(
      message: 'تم تصفير سجل الحضور للجميع',
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // تحديث نص البحث
  void updateSearchQuery(String query) {
    searchQuery.value = query.trim();
  }
}