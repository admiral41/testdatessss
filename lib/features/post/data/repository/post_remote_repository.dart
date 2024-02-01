import 'package:bigtalk/core/failure/failure.dart';
import 'package:bigtalk/features/post/data/data_source/post_remote_data_source.dart';
import 'package:bigtalk/features/post/domain/entity/Post_entity.dart';
import 'package:bigtalk/features/post/domain/repository/post_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postRemoteRepositoryProvider = Provider<IPostRepository>(
  (ref) => PostRemoteRepository(
    ref.read(postRemoteDataSourceProvider) as PostRemoteRepository,
  ),
);

class PostRemoteRepository implements IPostRepository {
  final PostRemoteRepository _postRemoteRepository;

  PostRemoteRepository(this._postRemoteRepository);

  @override
  Future<Either<Failure, bool>> createPost(PostEntity post) async {
    return await _postRemoteRepository.createPost(post);
  }
}
