import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/config/constants/api_endpoints.dart';
import 'package:hamropasalmobile/core/network/http_service.dart';
import 'package:hamropasalmobile/features/auth/data/model/auth_api_model.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource({required dio}) : _dio = dio;

  Future<String> uploadPicture(File imageFile) async {
    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      'profilePicture': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });

    Response response = await _dio.post(
      ApiEndpoints.uploadImage,
      data: formData,
    );

    return response.data['message'];
  }

  Future<bool> registerUser(AuthEntity user) async {
    var authModel = AuthApiModel.fromEntity(user);
    Response response =
        await _dio.post(ApiEndpoints.register, data: authModel.toJson());
    return response.statusCode == 200;
  }

  Future<String> login(String email, String password) async {
    final response = await _dio.post(ApiEndpoints.login,
        data: json.encode({"email": email, "password": password}));
    return response.data['accessToken'];
  }
}
