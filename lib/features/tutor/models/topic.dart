/// Model for a topic within a lesson in Firestore.
/// Matches structure: lessons/{lessonId}/topics/{topicId} with fields:
/// title, description, image_url, order, pdfUrl, video_url
class Topic {
  final String id;
  final String lessonId;
  final String title;
  final String description;
  final String imageUrl;
  final int order;
  final String pdfUrl;
  final String videoUrl;

  const Topic({
    required this.id,
    required this.lessonId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.order,
    required this.pdfUrl,
    required this.videoUrl,
  });

  Topic copyWith({
    String? id,
    String? lessonId,
    String? title,
    String? description,
    String? imageUrl,
    int? order,
    String? pdfUrl,
    String? videoUrl,
  }) {
    return Topic(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      order: order ?? this.order,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
