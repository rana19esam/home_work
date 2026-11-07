import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // حقن الكنترولر في الذاكرة باستخدام Get.put
    final controller = Get.put(AttendanceController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('كشف حضور وغياب الطلاب'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // 1. شريط الإحصائيات العلوي (يتم تحديثه تلقائياً بـ Obx)
            Obx(() => Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(title: 'الإجمالي', count: controller.totalStudents, color: Colors.blue),
                      _StatItem(title: 'الحاضرون', count: controller.presentCount, color: Colors.green),
                      _StatItem(title: 'الغائبون', count: controller.absentCount, color: Colors.red),
                    ],
                  ),
                )),

            // 2. محرك البحث وأزرار التحكم السريع
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: controller.updateSearchQuery,
                    decoration: InputDecoration(
                      hintText: 'ابحث عن اسم الطالب...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.markAllPresent,
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text('تحضير الكل'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.resetAll,
                          icon: const Icon(Icons.refresh),
                          label: const Text('تصفير الكل'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 3. قائمة الطلاب (نطاق الـ Rebuild محصور داخل Obx هنا لرفع الأداء)
            Expanded(
              child: Obx(() {
                final students = controller.filteredStudents;
                if (students.isEmpty) {
                  return const Center(child: Text('لا يوجد طلاب مطابقون للبحث'));
                }
                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(student.avatarUrl),
                        ),
                        title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          student.isPresent ? 'حاضر' : 'غائب',
                          style: TextStyle(color: student.isPresent ? Colors.green : Colors.red),
                        ),
                        trailing: Switch(
                          value: student.isPresent,
                          activeColor: Colors.green,
                          onChanged: (_) => controller.toggleAttendance(student.id),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// ويدجت مساعدة لعرض الإحصائيات
class _StatItem extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _StatItem({required this.title, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('$count', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}