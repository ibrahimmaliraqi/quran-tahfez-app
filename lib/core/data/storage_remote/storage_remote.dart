import 'dart:io';

import 'package:dio/dio.dart';
import 'package:quran_tahfez/core/constants/app_secret.dart';
import 'package:quran_tahfez/core/error/app_exceptions.dart';
import 'package:quran_tahfez/core/network/dio_client.dart';

abstract class StorageRemote {
  Future<String> uploadImage({required File image});
}

class ApiImgbbImpl implements StorageRemote {
  final DioClient dioClient;

  ApiImgbbImpl({required this.dioClient});
  @override
  Future<String> uploadImage({required File image}) async {
    String apiKey = AppSecret.iimguoload;

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

    if (response['success'] == true) {
      return response['data']['url'] as String;
    }

    throw ServerException(errMessage: 'فشل رفع الصورة');
  }
}
