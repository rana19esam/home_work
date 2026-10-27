import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const AdvancedCounterApp());
}

class AdvancedCounterApp extends StatelessWidget {
  const AdvancedCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Counter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CounterHomeScreen(),
    );
  }
}

class CounterHomeScreen extends StatefulWidget {
  const CounterHomeScreen({super.key});

  @override
  State<CounterHomeScreen> createState() => _CounterHomeScreenState();
}

class _CounterHomeScreenState extends State<CounterHomeScreen> {
  // متغيرات الحالة (State Variables)
  int _counter = 0;
  bool _isRunning = false;
  int _incrementStep = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // تهيئة البداية: طباعة سجل لمتابعة دورة الحياة
    debugPrint('--> [initState]: تم إنشاء الشاشة وبدء تهيئة البيانات.');
    _startTimer();
  }

  /// بدء أو إعادة تشغيل المؤقت الدوري
  void _startTimer() {
    _timer?.cancel(); // إلغاء أي مؤقت سابق إذا وجد
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning) {
        setState(() {
          _counter += _incrementStep;
        });
      }
    });
    setState(() {
      _isRunning = true;
    });
    debugPrint('--> [Timer]: تم تشغيل المؤقت الدوري.');
  }

  /// إيقاف المؤقت مؤقتاً
  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
    debugPrint('--> [Timer]: تم إيقاف المؤقت مؤقتاً.');
  }

  /// إعادة ضبط العداد
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  void dispose() {
    // إيقاف المؤقت نهائياً لمنع Memory Leak
    _timer?.cancel();
    debugPrint('--> [dispose]: تم إلغاء المؤقت وتنظيف الموارد بنجاح.');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عداد متقدم - Stateful LifeCycle'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // بطاقة عرض قيمة العداد
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30.0,
                    horizontal: 50.0,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'القيمة الحالية:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$_counter',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // حالة التشغيل
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isRunning ? Icons.play_circle_fill : Icons.pause_circle_filled,
                    color: _isRunning ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isRunning ? 'المؤقت يعمل (تلقائي)' : 'المؤقت متوقف مؤقتاً',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // أزرار التحكم بالمؤقت والعداد
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                    label: Text(_isRunning ? 'إيقاف مؤقت' : 'تشغيل'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRunning ? Colors.amber.shade700 : Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _counter += _incrementStep;
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('زيادة +1'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _resetCounter,
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة ضبط'),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // اختيار خطوة الزيادة
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('مقدار الزيادة: '),
                  DropdownButton<int>(
                    value: _incrementStep,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('+1')),
                      DropdownMenuItem(value: 5, child: Text('+5')),
                      DropdownMenuItem(value: 10, child: Text('+10')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _incrementStep = value;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}