import 'package:bigtalk/features/post/domain/entity/Post_entity.dart';
import 'package:bigtalk/features/post/domain/use_case/post_usecase.dart';
import 'package:bigtalk/features/post/presentation/state/post_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postViewModelProvider = StateNotifierProvider<PostViewModel, PostState>(
  (ref) => PostViewModel(ref.read(postUseCaseProvider)),
);

class PostViewModel extends StateNotifier<PostState> {
  final PostUseCase _postUseCase;

  PostViewModel(this._postUseCase) : super(PostState.initial());

  Future<void> createPost(PostEntity post) async {
    state = state.copyWith(isLoading: true);
    final result = await _postUseCase.createPost(post);
    state = state.copyWith(isLoading: false);
    result.fold(
      (failure) => state = state.copyWith(error: failure.error),
      (success) => state = state.copyWith(isLoading: false, showMessage: true),
    );
    resetMessage();
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  void resetMessage() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }
}
