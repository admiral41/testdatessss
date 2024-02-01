import 'package:bigtalk/features/auth/domain/entity/auth_entity.dart';
import 'package:bigtalk/features/post/data/model/post_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String name;
  final String username;
  final String email;
  final String? password;
  final List<PostApiModel>? posts;
  final List<String>? followers; // Add this line
  final List<String>? following; // Add this line
  AuthApiModel({
    this.userId,
    required this.name,
    required this.username,
    required this.email,
    this.password,
    this.followers,
    this.posts,
    this.following,
  });
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // to entity
  factory AuthApiModel.toEntity(AuthApiModel apimodel) {
    return AuthApiModel(
      userId: apimodel.userId,
      name: apimodel.name,
      username: apimodel.username,
      email: apimodel.email,
      password: apimodel.password,
      followers: apimodel.followers,
      following: apimodel.following,
    );
  }

  // from entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      userId: entity.userId,
      name: entity.name,
      username: entity.username,
      email: entity.email,
      password: entity.password,
      followers: entity.followers,
      following: entity.following,
    );
  }
}
