import 'package:dio/dio.dart';

class DioClient {
  final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: 'https://www.mentormeter.online',
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              print('REQUEST: ${options.method} ${options.uri}');
         

              handler.next(options);
            },
            onResponse: (response, handler) {
              print("StatusCode: ${response.statusCode}");
              print("response: ${response.data}");
              handler.next(response);
            },
            onError: (error, handler) {
              print('Error: ${error.message}');
     

              handler.next(error);
            },
          ),
        );
}
