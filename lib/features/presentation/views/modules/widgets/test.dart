import 'package:flutter/material.dart';
import '../../../../../utils/enums.dart';

class TestItem {
  final String id;
  final String title;
  final String description;
  final TestStatus status;
  final IconData icon;
  final String? score;
  final int? totalQuestions;
  final int? correctAnswers;
  final int? incorrectAnswers;
  final String? gradeText;
  final String? date;
  final String? tutorComment;
  final bool isMarked;

  TestItem({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.icon,
    this.score,
    this.totalQuestions,
    this.correctAnswers,
    this.incorrectAnswers,
    this.gradeText,
    this.date,
    this.tutorComment,
    this.isMarked = false,
  });
}