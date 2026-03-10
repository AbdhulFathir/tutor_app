/// Model for a lesson in Firestore.
/// Matches structure: lessons/{lessonId} with fields:
/// title, description, image_url, group, order, totalTopics
class Lesson {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String group;
  final int order;
  final int totalTopics;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.group,
    required this.order,
    required this.totalTopics,
  });

  Lesson copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? group,
    int? order,
    int? totalTopics,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      group: group ?? this.group,
      order: order ?? this.order,
      totalTopics: totalTopics ?? this.totalTopics,
    );
  }
}
