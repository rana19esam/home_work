class Student {
  final String id;
  final String name;
  final String avatarUrl;
  bool isPresent;

  Student({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isPresent = false,
  });

  // نسخة معدلة لتحديث حالة الطالب بسهولة
  Student copyWith({bool? isPresent}) {
    return Student(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}