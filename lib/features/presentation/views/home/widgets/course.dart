import '../../../../../utils/enums.dart';

class Course {
  final String title;
  final String description;
  final String? imageUrl;
  final CourseStatus courseStatus;

  Course({
    required this.title,
    required this.description,
    this.imageUrl,
    this.courseStatus = CourseStatus.ALL
  });
}