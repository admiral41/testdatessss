import 'package:bigtalk/core/failure/failure.dart';
import 'package:bigtalk/features/post/domain/entity/Post_entity.dart';
import 'package:bigtalk/features/post/domain/repository/post_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postUseCaseProvider = Provider<PostUseCase>(
  (ref) => PostUseCase(
    ref.read(postRepositoryProvider),
  ),
);

class PostUseCase {
  final IPostRepository _postRepository;

  PostUseCase(this._postRepository);

  Future<Either<Failure, bool>> createPost(PostEntity post) async {
    return await _postRepository.createPost(post);
  }
}
