class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String grade;
  final String? classGroupId;
  final String username;
  final String password;

  const Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.grade,
    required this.username,
    required this.password,
    this.classGroupId,
  });

  String get fullName => '$firstName $lastName'.trim();

  Student copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? grade,
    String? classGroupId,
    String? username,
    String? password,
  }) {
    return Student(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      grade: grade ?? this.grade,
      classGroupId: classGroupId ?? this.classGroupId,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}

