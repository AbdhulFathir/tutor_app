import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreTest {
  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;
  final String group;
  final String testUrl;
  final int totalQuestions;
  final DateTime? createdAt;

  const FirestoreTest({
    required this.id,
    required this.title,
    this.description = '',
    this.dueDate,
    required this.group,
    this.testUrl = '',
    this.totalQuestions = 0,
    this.createdAt,
  });

  factory FirestoreTest.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return FirestoreTest(
      id: doc.id,
      title: (data['title'] ?? '').toString(),
      description: (data['description'] ?? '').toString(),
      dueDate: _parseTimestamp(data['dueDate']),
      group: (data['group'] ?? '').toString(),
      testUrl: (data['test_url'] ?? '').toString(),
      totalQuestions: (data['totalQuestions'] is int)
          ? data['totalQuestions'] as int
          : int.tryParse((data['totalQuestions'] ?? '0').toString()) ?? 0,
      createdAt: _parseTimestamp(data['createdAt']),
    );
  }

  static DateTime? _parseTimestamp(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'group': group,
      'test_url': testUrl,
      'totalQuestions': totalQuestions,
      if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
    };
  }

  FirestoreTest copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? group,
    String? testUrl,
    int? totalQuestions,
    DateTime? createdAt,
  }) {
    return FirestoreTest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      group: group ?? this.group,
      testUrl: testUrl ?? this.testUrl,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
