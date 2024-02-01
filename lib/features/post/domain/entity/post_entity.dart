import 'package:bigtalk/features/post/data/model/post_api_model.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? postId;
  final String caption;
  final List<String> image;
  final List<String>? likes;
  final List<String>? comments; // Changed to dynamic for flexibility
  final String? ownerId;

  const PostEntity({
    this.postId,
    required this.caption,
    required this.image,
    this.likes,
    this.comments,
    this.ownerId,
  });

  factory PostEntity.fromApiModel(PostApiModel postApi) {
    return PostEntity(
      postId: postApi.postId,
      caption: postApi.caption,
      image: postApi.image,
      likes: postApi.likes,
      comments: postApi.comments,
      ownerId: postApi.ownerId,
    );
  }

  @override
  List<Object?> get props => [
        postId,
        caption,
        image,
        likes,
        comments,
        ownerId,
      ];
}
