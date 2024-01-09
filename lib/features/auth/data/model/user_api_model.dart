import 'package:hamropasalmobile/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserAPiModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String username;
  final String password;

  UserAPiModel({this.userId, required this.username, required this.password});

  factory UserAPiModel.fromJson(Map<String, dynamic> json) {
    return UserAPiModel(
        userId: json['_id'],
        username: json['username'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username, 
      'password': password
      };
  }

  // From entity to model
  factory UserAPiModel.fromEntity(UserEntity user) {
    return UserAPiModel(
      username: user.username,
      password: user.password
    );
  }

  // From model to entity
  static UserEntity toEntity(UserAPiModel model) {
    return UserEntity(
      userId: model.userId,
      username: model.username,
      password: model.password,
    );
  }
}
