import 'package:bigtalk/features/auth/data/model/auth_api_model.dart';
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String name;
  final String username;
  final String? password;
  final String email;
  final List<String>? followers;
  final List<String>? following; // Add this line

  const AuthEntity(
      {this.userId,
      required this.name,
      required this.username,
      this.password,
      required this.email,
      this.followers,
      this.following});

  // Add this method to convert AuthApiModel to AuthEntity
  factory AuthEntity.fromApiModel(AuthApiModel apiModel) {
    return AuthEntity(
      userId: apiModel.userId,
      name: apiModel.name,
      username: apiModel.username,
      password: apiModel.password ?? "", // You may need to handle null password
      email: apiModel.email,
      followers: const [],
      following: const [], // Initialize to empty list
    );
  }

  @override
  List<Object?> get props => [
        userId,
        name,
        username,
        password,
        email,
        followers,
        following
      ]; // Update this line
}
