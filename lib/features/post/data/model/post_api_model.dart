import 'package:bigtalk/features/post/domain/entity/Post_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_api_model.g.dart';

@JsonSerializable()
class PostApiModel {
  @JsonKey(name: '_id')
  final String? postId;
  final String caption;
  final List<String> image;
  final List<String>? likes;
  final List<String>? comments;
  @JsonKey(name: 'owner')
  final String? ownerId;

  PostApiModel({
    this.postId,
    required this.caption,
    required this.image,
    this.likes,
    this.comments,
    this.ownerId,
  });

  factory PostApiModel.fromJson(Map<String, dynamic> json) =>
      _$PostApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostApiModelToJson(this);

  // Convert to entity
  factory PostApiModel.toEntity(PostApiModel apiModel) {
    return PostApiModel(
      postId: apiModel.postId,
      caption: apiModel.caption,
      image: apiModel.image,
      likes: apiModel.likes,
      comments: apiModel.comments,
      ownerId: apiModel.ownerId,
    );
  }

  // Convert from entity
  factory PostApiModel.fromEntity(PostEntity entity) {
    return PostApiModel(
      postId: entity.postId,
      caption: entity.caption,
      image: entity.image,
      likes: entity.likes,
      comments: entity.comments,
      ownerId: entity.owner?.userId ?? '', // Handle null safety
    );
  }
}
