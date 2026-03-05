import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/admin_user.dart';
import '../models/announcement.dart';
import '../models/class_group.dart';
import '../models/material_item.dart';
import '../models/notification_item.dart';
import '../models/poll.dart';
import '../models/student.dart';
import '../models/test_item.dart';

String _randomId() {
  final rand = Random();
  final millis = DateTime.now().millisecondsSinceEpoch;
  final n = rand.nextInt(1 << 31);
  return '$millis-$n';
}

class TutorStore extends StateNotifier<TutorStoreState> {
  TutorStore() : super(TutorStoreState.initial());

  void addClassGroup(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final group = ClassGroup(id: _randomId(), name: trimmed);
    state = state.copyWith(classGroups: [...state.classGroups, group]);
  }

  void deleteClassGroup(String id) {
    state = state.copyWith(
      classGroups: state.classGroups.where((g) => g.id != id).toList(),
      students: state.students
          .map((s) => s.classGroupId == id ? s.copyWith(classGroupId: null) : s)
          .toList(),
    );
  }

  void addStudent(Student student) {
    state = state.copyWith(students: [...state.students, student]);
  }

  void updateStudent(Student student) {
    state = state.copyWith(
      students: [
        for (final s in state.students) if (s.id == student.id) student else s,
      ],
    );
  }

  void deleteStudent(String id) {
    state = state.copyWith(students: state.students.where((s) => s.id != id).toList());
  }

  void addTest(TutorTest test) {
    state = state.copyWith(tests: [...state.tests, test]);
  }

  void deleteTest(String id) {
    state = state.copyWith(tests: state.tests.where((t) => t.id != id).toList());
  }

  void addMaterial(TutorMaterialItem item) {
    state = state.copyWith(materials: [...state.materials, item]);
  }

  void deleteMaterial(String id) {
    state =
        state.copyWith(materials: state.materials.where((m) => m.id != id).toList());
  }

  void addAnnouncement(Announcement announcement) {
    state = state.copyWith(announcements: [...state.announcements, announcement]);
  }

  void deleteAnnouncement(String id) {
    state = state.copyWith(
        announcements:
            state.announcements.where((a) => a.id != id).toList());
  }

  void addPoll(Poll poll) {
    state = state.copyWith(polls: [...state.polls, poll]);
  }

  void deletePoll(String id) {
    state = state.copyWith(polls: state.polls.where((p) => p.id != id).toList());
  }

  void addAdmin(AdminUser admin) {
    state = state.copyWith(admins: [...state.admins, admin]);
  }

  void deleteAdmin(String id) {
    state = state.copyWith(admins: state.admins.where((a) => a.id != id).toList());
  }
}

class TutorStoreState {
  final List<Student> students;
  final List<ClassGroup> classGroups;
  final List<TutorTest> tests;
  final List<TutorMaterialItem> materials;
  final List<Announcement> announcements;
  final List<Poll> polls;
  final List<AdminUser> admins;
  final List<TutorNotificationItem> notifications;

  const TutorStoreState({
    required this.students,
    required this.classGroups,
    required this.tests,
    required this.materials,
    required this.announcements,
    required this.polls,
    required this.admins,
    required this.notifications,
  });

  factory TutorStoreState.initial() {
    final webDev = ClassGroup(id: _randomId(), name: 'Web Dev 2025');
    final webStu = ClassGroup(id: _randomId(), name: 'Web Stu 2025');
    return TutorStoreState(
      classGroups: [webDev, webStu],
      students: [
        Student(
          id: _randomId(),
          firstName: 'Senuri',
          lastName: 'Perera',
          phoneNumber: '+94 77 123 4567',
          email: 'senuri@example.com',
          grade: '10',
          classGroupId: webDev.id,
          username: 'senuri',
          password: 'Password@123',
        ),
      ],
      tests: [
        TutorTest(
          id: _randomId(),
          title: 'Mid Term Test',
          date: DateTime(2025, 7, 28),
          totalQuestions: 20,
          passMark: 50,
        ),
      ],
      materials: [
        TutorMaterialItem(
          id: _randomId(),
          title: 'Supervised Learning Notes',
          description: 'PDF handout for supervised learning lesson.',
        ),
      ],
      announcements: [
        Announcement(
          id: _randomId(),
          title: 'Class on 28 July',
          body: 'Please bring your laptops for the practical session.',
        ),
      ],
      polls: [
        Poll(
          id: _randomId(),
          question: 'Was today’s lesson helpful?',
        ),
      ],
      admins: [
        AdminUser(
          id: _randomId(),
          name: 'Senuri',
          role: 'Owner',
        ),
      ],
      notifications: [
        TutorNotificationItem(
          id: _randomId(),
          title: 'New student joined',
          body: 'A new student has been added to Web Dev 2025.',
          date: DateTime.now(),
        ),
      ],
    );
  }

  TutorStoreState copyWith({
    List<Student>? students,
    List<ClassGroup>? classGroups,
    List<TutorTest>? tests,
    List<TutorMaterialItem>? materials,
    List<Announcement>? announcements,
    List<Poll>? polls,
    List<AdminUser>? admins,
    List<TutorNotificationItem>? notifications,
  }) {
    return TutorStoreState(
      students: students ?? this.students,
      classGroups: classGroups ?? this.classGroups,
      tests: tests ?? this.tests,
      materials: materials ?? this.materials,
      announcements: announcements ?? this.announcements,
      polls: polls ?? this.polls,
      admins: admins ?? this.admins,
      notifications: notifications ?? this.notifications,
    );
  }
}

final tutorStoreProvider = StateNotifierProvider<TutorStore, TutorStoreState>((ref) {
  return TutorStore();
});

