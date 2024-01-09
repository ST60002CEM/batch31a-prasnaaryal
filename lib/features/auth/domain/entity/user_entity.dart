import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String username;
  final String password;

  const UserEntity({
    this.userId,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, username, password];
  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        userId: json["userId"],
        username: json["username"],
        password: json["password"]
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "password":password
      };

  @override
  String toString() {
    return 'UserEntity(userId: $userId, username: $username, password: $password)';
  }
}
