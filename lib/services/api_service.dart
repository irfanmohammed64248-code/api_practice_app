import 'package:api_post_three/models/auth_model.dart';
import 'package:api_post_three/models/review_model.dart';
import 'package:api_post_three/services/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ApiService {
  final DioClient dioClient = DioClient();

  Future<AuthModel> login({
     required String email,
     required String password,
  })async{
     final response = await dioClient.dio.post('/api/auth/login',
     data: {
      "email":email,
      "password":password,
     }
     );
      final authModel = AuthModel.fromJson(response.data as Map<String,dynamic>);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("access_token", authModel.accessToken);
      await prefs.setString("refresh_token", authModel.refreshToken);

      print("AccessToken Saved: ${prefs.containsKey("access_token")}");
      print("RefreshToken Saved: ${prefs.containsKey("refresh_token")}");



      return authModel;
     
  } 
   
   Future<List<ReviewModel>> getReviews()async{

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

     if(token == null){
      throw Exception("please login first");
     }
       
     final response = await dioClient.dio.get("/api/reviews",
      options: Options(
        headers: {
        'Authorization': 'Bearer $token',
        }
      )
     );

     final List data = response.data;
      return data.map((json) =>ReviewModel.fromJson(json)).toList();
   }

}