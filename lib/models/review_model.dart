class ReviewModel {
  final String id;
  final String userId;
  final String mentorName;
  final String internName;
  final String reviewDate;
  final String reviewTopic;
  final double reviewScore;
  final String createdAt;
  final String updatedAt;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.mentorName,
    required this.internName,
    required this.reviewDate,
    required this.reviewTopic,
    required this.reviewScore,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      mentorName: json['mentor_name'] as String,
      internName: json['intern_name'] as String,
      reviewDate: json['review_date'] as String,
      reviewTopic: json['review_topic'] as String,
      reviewScore: double.parse(json['review_score'].toString()),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}