import 'package:hamropasalmobile/config/constants/hive_table_constant.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'package:uuid/uuid.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String password;

  

  // Constructor
  UserHiveModel({
    String? userId,
    
    required this.username,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  UserHiveModel.empty()
      : this(
          userId: '',
          
          username: '',
          password: '',
        );

  
  // Convert Hive Object to Entity
  static UserEntity toEntity(UserHiveModel hiveModel) => UserEntity(
        userId: hiveModel.userId,
        username: hiveModel.username,
        password: hiveModel.password
      );

  // Convert Entity to Hive Object
  factory UserHiveModel.toHiveModel(UserEntity entity) => UserHiveModel(
        // batchId: entity.batchId,
        username: entity.username,
        password: entity.password
      );


  @override
  String toString() {
    return 'userId: $userId,  username: $username, password: $password';
  }
}
