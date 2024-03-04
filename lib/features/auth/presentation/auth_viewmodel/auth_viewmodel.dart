import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/config/router/app_route.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';
import 'package:hamropasalmobile/features/auth/domain/use_case/login_usecase.dart';
import 'package:hamropasalmobile/features/auth/domain/use_case/register_usecase.dart';
import 'package:hamropasalmobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:hamropasalmobile/features/auth/presentation/state/auth_state.dart';
import 'package:hamropasalmobile/features/home/presentation/views/bottom_tab_bar.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(registerUseCaseProvider),
    ref.read(loginUseCaseProvider),
    ref.read(uploadImageUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final UploadImageUseCase _uploadImageUsecase;

  AuthViewModel(
    // TODO: Cleanup and make this more readable
    this._registerUseCase,
    this._loginUseCase,
    this._uploadImageUsecase,
  ) : super(AuthState.initial());

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    // Read the file as bytes
    List<int> imageBytes = await file!.readAsBytes();

    // Encode the image bytes to base64
    String base64Image = base64Encode(imageBytes);

    state = state.copyWith(
      isLoading: false,
      error: null,
      imageName: base64Image,
    );
  }

  Future<void> registerUser(AuthEntity entity) async {
    state = state.copyWith(isLoading: true);
    final result = await _registerUseCase.registerUser(entity);
    state = state.copyWith(isLoading: false);
    result.fold(
      (failure) => state = state.copyWith(error: failure.error),
      (success) => state = state.copyWith(isLoading: false, showMessage: true),
    );

    resetMessage();
  }

  //Login
  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await _loginUseCase.loginUser(email, password);
    state = state.copyWith(isLoading: false);
    result.fold(
      (failure) => state = state.copyWith(
        error: failure.error,
        showMessage: true,
      ),
      (success) {
        state = state.copyWith(
          isLoading: false,
          showMessage: true,
          error: null,
        );

        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (bldr) => const PersistentBottomNavigationBar(),
          ),
        );
      },
    );
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      imageName: null,
      showMessage: false,
    );
  }

  void resetMessage() {
    state = state.copyWith(
        showMessage: false, imageName: null, error: null, isLoading: false);
  }
}
