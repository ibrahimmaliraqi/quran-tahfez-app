import 'dart:io';

import 'package:dio/dio.dart';
import 'package:quran_tahfez/core/network/dio_client.dart';

abstract class StorageRemote {
  Future<String> uploadImage({required File image});
}

class ApiImgbbImpl implements StorageRemote {
  final DioClient dioClient;

  ApiImgbbImpl({required this.dioClient});
  @override
  Future<String> uploadImage({required File image}) async {
    const String apiKey = '2f7b358689bab1f6f18d08712310e003';

    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path),
    });

    final response = await dioClient.post(
      'https://api.imgbb.com/1/upload',
      queryParameters: {
        'key': apiKey,
      },
      data: formData,
    );

    if (response.statusCode == 200 && response.data['success'] == true) {
      return response.data['data']['url'] as String;
    }

    throw Exception('فشل رفع الصورة');
  }
}
