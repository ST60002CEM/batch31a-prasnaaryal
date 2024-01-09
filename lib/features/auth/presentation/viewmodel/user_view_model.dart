import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/features/auth/domain/use_case/add_user_usecase.dart';
import 'package:hamropasalmobile/features/auth/presentation/state/user_state.dart';

import '../../domain/entity/user_entity.dart';

final userViewModelProvider =
    StateNotifierProvider.autoDispose<UserViewModel, UserState>(
      (ref) =>UserViewModel(
          addUserUsecase: ref.read(addUserUseCaseProvider)));

class UserViewModel extends StateNotifier<UserState> {
  final AddUserUseCase addUserUsecase;

  UserViewModel({
    required this.addUserUsecase,
  }) : super(UserState.initialState());

  void addUser(UserEntity userEntity) {
    state = state.copyWith(isLoading: true);
    addUserUsecase.registerUser(userEntity).then((value) {
      value.fold(
        (failure) => state = state.copyWith(isLoading: false),
        (success) {
          state = state.copyWith(isLoading: false, showMessage: true);
        },
      );
    });
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
