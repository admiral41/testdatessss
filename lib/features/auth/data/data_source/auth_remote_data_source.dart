import 'package:bigtalk/config/constants/api_endpoints.dart';
import 'package:bigtalk/core/failure/failure.dart';
import 'package:bigtalk/core/network/http_service.dart';
import 'package:bigtalk/features/auth/data/model/auth_api_model.dart';
import 'package:bigtalk/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
    ref.read(httpServiceProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      AuthApiModel apiModel = AuthApiModel.fromEntity(user);
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          'name': apiModel.name,
          'username': apiModel.username,
          'email': apiModel.email,
          'password': apiModel.password,
        },
      );
      // Check the response and handle accordingly
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        // Successful login
        return const Right(true);
      } else {
        // Failed login
        return Left(
          Failure(
            error: response.data["message"] ?? "Login failed",
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<AuthEntity>>> searchUserByName(
      String name) async {
    try {
      final token = ApiEndpoints.token;

      Response response = await dio.post(
        ApiEndpoints.searchUserByName,
        data: {
          "name": name,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        List<AuthApiModel> userListApi = (response.data["users"] as List)
            .map((userJson) => AuthApiModel.fromJson(userJson))
            .toList();

        if (userListApi.isNotEmpty) {
          List<AuthEntity> userList = userListApi
              .map((userApi) => AuthEntity.fromApiModel(userApi))
              .toList();
          return Right(userList);
        } else {
          return Left(
            Failure(
              error: "No users found",
              statusCode: response.statusCode.toString(),
            ),
          );
        }
      } else {
        return Left(
          Failure(
            error: response.data["message"] ?? "Search failed",
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> followUser(String userId) async {
    try {
      final token = ApiEndpoints.token;

      Response response = await dio.get(
        ApiEndpoints.followUser.replaceAll(':id', userId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"] ?? "Follow failed",
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
