import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserWrapper {
  final User user;

  UserWrapper({required this.user});

  factory UserWrapper.fromJson(Map<String, dynamic> json) => _$UserWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$UserWrapperToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  @JsonKey(name: '__v')
  final int v;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
