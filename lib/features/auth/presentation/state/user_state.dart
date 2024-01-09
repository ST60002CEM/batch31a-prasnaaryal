
import 'package:hamropasalmobile/features/auth/domain/entity/user_entity.dart';

class UserState {
  final bool isLoading;
  final List<UserEntity> users;
  final bool showMessage;

  UserState(
      {required this.isLoading,
      required this.users,
      required this.showMessage});

  factory UserState.initialState() =>
      UserState(isLoading: false, users: [], showMessage: false);

  UserState copyWith({
    bool? isLoading,
    List<UserEntity>? users,
    bool? showMessage,
  }) {
    return UserState(
        isLoading: isLoading ?? this.isLoading,
        users: users ?? this.users,
        showMessage: showMessage ?? this.showMessage);
  }
}
