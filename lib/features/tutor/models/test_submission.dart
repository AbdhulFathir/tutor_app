import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a single student's submission for a test.
/// Backed by the `submision` collection used in the student app.
class TestSubmission {
  final String id;
  final String testId;
  final String userId;
  final String driveLink;
  final bool submitted;
  final DateTime? submittedAt;
  final bool isMarked;
  final int score;
  final int correctAnswers;
  final int incorrectAnswers;
  final String gradeText;
  final String tutorComment;

  const TestSubmission({
    required this.id,
    required this.testId,
    required this.userId,
    required this.driveLink,
    required this.submitted,
    required this.submittedAt,
    required this.isMarked,
    required this.score,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.gradeText,
    required this.tutorComment,
  });

  factory TestSubmission.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};
    return TestSubmission(
      id: doc.id,
      testId: (data['testId'] ?? '').toString(),
      userId: (data['userId'] ?? '').toString(),
      driveLink: (data['drive_link'] ?? '').toString(),
      submitted: data['submitted'] as bool? ?? false,
      submittedAt: _parseTimestamp(data['submittedAt']),
      isMarked: data['isMarked'] as bool? ?? false,
      score: _asInt(data['score']),
      correctAnswers: _asInt(data['correctAnswers']),
      incorrectAnswers: _asInt(data['incorrectAnswers']),
      gradeText: (data['gradeText'] ?? '').toString(),
      tutorComment: (data['tutorComment'] ?? '').toString(),
    );
  }

  static DateTime? _parseTimestamp(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }

  static int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value == null) return 0;
    return int.tryParse(value.toString()) ?? 0;
  }

  TestSubmission copyWith({
    String? id,
    String? testId,
    String? userId,
    String? driveLink,
    bool? submitted,
    DateTime? submittedAt,
    bool? isMarked,
    int? score,
    int? correctAnswers,
    int? incorrectAnswers,
    String? gradeText,
    String? tutorComment,
  }) {
    return TestSubmission(
      id: id ?? this.id,
      testId: testId ?? this.testId,
      userId: userId ?? this.userId,
      driveLink: driveLink ?? this.driveLink,
      submitted: submitted ?? this.submitted,
      submittedAt: submittedAt ?? this.submittedAt,
      isMarked: isMarked ?? this.isMarked,
      score: score ?? this.score,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers,
      gradeText: gradeText ?? this.gradeText,
      tutorComment: tutorComment ?? this.tutorComment,
    );
  }
}

