import 'package:api_post_three/models/review_model.dart';
import 'package:api_post_three/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final reviewProvider = FutureProvider<List<ReviewModel>>((ref) async{
  final apiService =  ref.read(apiServiceProvider);
  return apiService.getReviews();
},);