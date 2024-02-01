import 'package:bigtalk/core/failure/failure.dart';
import 'package:bigtalk/features/post/data/repository/post_remote_repository.dart';
import 'package:bigtalk/features/post/domain/entity/Post_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postRepositoryProvider = Provider<IPostRepository>(
  (ref) => ref.read(postRemoteRepositoryProvider),
);

abstract class IPostRepository {
  Future<Either<Failure, bool>> createPost(PostEntity post);
}
