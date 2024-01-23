import 'package:equatable/equatable.dart';
import 'package:hamropasalmobile/config/constants/hive_table_constant.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String email;



  @HiveField(4)
  final String password;

  @HiveField(5)
  final String confirmPassword;

  // @HiveField(6)
  // final String image;

  // Constructor
  AuthHiveModel({
    String? userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    // required this.image,
  }) : userId = userId ?? const Uuid().v4();

  // // empty constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          firstName: '',
          lastName: '',
          email: '',
          // image: '',
          confirmPassword: '',
          password: '',
        );

  // Convert Entity to Hive Object
  factory AuthHiveModel.toHiveModel(AuthEntity entity) => AuthHiveModel(
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        // image: entity.image,
      
      
        confirmPassword: entity.confirmPassword,
        password: entity.password,
      );

  // Convert Hive Object to Entity
  static AuthEntity toEntity(AuthHiveModel hiveModel) => AuthEntity(
        userId: hiveModel.userId,
        firstName: hiveModel.firstName,
        lastName: hiveModel.lastName,
        email: hiveModel.email,
        // image: hiveModel.image,
      
        confirmPassword: hiveModel.confirmPassword,
        password: hiveModel.password,
      );

  @override
  String toString() {
    return 'userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, password: $password, confirmPassword: $confirmPassword';
  }

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        email,
        
        
        confirmPassword,
        password,
      ];
}