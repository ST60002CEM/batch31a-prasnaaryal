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

  AuthRemoteDataSource({required dio}): _dio = dio;

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

/**
 * Removed Unnecessary complexity from the remote source
 *
 */
// class AuthRemoteDataSource {
//   final Dio dio;

//   AuthRemoteDataSource(this.dio);

//   // Upload image using multipart
//   Future<Either<Failure, String>> uploadProfilePicture(
//     File image,
//   ) async {
//     try {
//       String fileName = image.path.split('/').last;
//       FormData formData = FormData.fromMap(
//         {
//           'profilePicture': await MultipartFile.fromFile(
//             image.path,
//             filename: fileName,
//           ),
//         },
//       );

//       Response response = await dio.post(
//         ApiEndpoints.uploadImage,
//         data: formData,
//       );

//       return Right(response.data["data"]);
//     } on DioException catch (e) {
//       return Left(
//         Failure(
//           error: e.error.toString(),
//           statusCode: e.response?.statusCode.toString() ?? '0',
//         ),
//       );
//     }
//   }

//   Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
//     try {
//       AuthApiModel apiModel = AuthApiModel.fromEntity(user);
//       Response response = await dio.post(
//         ApiEndpoints.register,
//         data: {
//           "firstName": apiModel.firstName,
//           "lastName": apiModel.lastName,
//           "image": apiModel.image,
//           "email": apiModel.email,
//           "confirmPassword": apiModel.confirmPassword,
//           "password": apiModel.password,
//         },

//         // "course": ["6489a5908dbc6d39719ec19c", "6489a5968dbc6d39719ec19e"]
//       );
//       if (response.statusCode == 200) {
//         return const Right(true);
//       } else {
//         return Left(
//           Failure(
//             error: response.data["message"],
//             statusCode: response.statusCode.toString(),
//           ),
//         );
//       }
//     } on DioException catch (e) {
//       return Left(
//         Failure(
//           error: e.error.toString(),
//           statusCode: e.response?.statusCode.toString() ?? '0',
//         ),
//       );
//     }
//   }

//   Future<Either<Failure, String>> loginUser(String email, String password) async {
//     try {
//       final response = await dio.post(ApiEndpoints.login,
//           data: json.encode({"email": email, "password": password}));

//       if (response.statusCode == 200) {
//         String accessToken = response.data['accessToken'];
//         return Right(accessToken);
//       } else {
//         return Left(
//           Failure(
//             error: response.data["message"],
//             statusCode: response.statusCode.toString(),
//           ),
//         );
//       }
//     } on DioException catch (e) {
//       return Left(
//         Failure(
//           error: e.error.toString(),
//           statusCode: e.response?.statusCode.toString() ?? '0',
//         ),
//       );
//     }
//   }
// }


