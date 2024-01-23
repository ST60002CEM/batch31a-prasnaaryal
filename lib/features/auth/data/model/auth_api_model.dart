import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String firstName;
  final String lastName;
  final String? image;
  final String email;
  
  final String confirmPassword;
  final String? password;

  AuthApiModel({
    this.userId,
    required this.firstName,
    required this.lastName,
    this.image,
    required this.email,
    
    required this.confirmPassword,
    this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To entity
  factory AuthApiModel.toEntity(AuthApiModel apiModel) {
    return AuthApiModel(
      userId: apiModel.userId,
      firstName: apiModel.firstName,
      lastName: apiModel.lastName,
      image: apiModel.image,
      email: apiModel.email,
      
      confirmPassword: apiModel.confirmPassword,
      password: apiModel.password,
    );
  }

  // From entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      userId: entity.userId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      image: entity.image,
      email: entity.email,
     
      confirmPassword: entity.confirmPassword,
      password: entity.password,
    );
  }
}
  