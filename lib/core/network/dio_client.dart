import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(
          validateStatus: (status) {
            return status != null && status < 500;
          },
          baseUrl: "http://hifzquran.mywebcommunity.org/",
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data;
  }
}
