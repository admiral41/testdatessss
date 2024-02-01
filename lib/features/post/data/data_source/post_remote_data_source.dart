import 'package:bigtalk/config/constants/api_endpoints.dart';
import 'package:bigtalk/core/failure/failure.dart';
import 'package:bigtalk/core/network/http_service.dart';
import 'package:bigtalk/features/post/data/model/post_api_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postRemoteDataSourceProvider = Provider<PostRemoteDataSource>(
  (ref) => PostRemoteDataSource(
    ref.read(httpServiceProvider),
  ),
);

class PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSource(this.dio);

  Future<Either<Failure, bool>> createPost(PostApiModel post) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.createPost,
        data: {
          'caption': post.caption,
          'image': post.image,
          'owner': post.ownerId,
        },
      );

      if (response.statusCode == 201) {
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
}
