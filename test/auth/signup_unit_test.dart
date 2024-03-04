import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';
import 'package:hamropasalmobile/features/auth/domain/use_case/register_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RegisterUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late MockRegisterUseCase mockRegisterUseCase;

  setUpAll(() async {
    mockRegisterUseCase = MockRegisterUseCase();
  });

  group('test register', () {
    setUpAll(() {
      /// if provided certain credential returen the proper mock user
      when(
        mockRegisterUseCase.registerUser(AuthEntity(
          email: 'test@example.com',
          confirmPassword: 'password',
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwX30TYblQfkT6KQjErIsceWYu1ievYU1iIQ&usqp=CAU",
          password: 'password',
          firstName: 'Test',
          lastName: 'User',
        )),
      ).thenAnswer(
        (_) async => const Right(true),
      );
    });

    test('test signup with proper cradential', () async {
      // Call the login method
      final result = await mockRegisterUseCase.registerUser(AuthEntity(
        email: 'test@example.com',
        confirmPassword: 'password',
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwX30TYblQfkT6KQjErIsceWYu1ievYU1iIQ&usqp=CAU",
        password: 'password',
        firstName: 'Test',
        lastName: 'User',
      ));

      // Verify the expected result
      expect(result, const Right(true));
    });

    test('test signup with invalid credentials', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'Please enter valid email',
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockRegisterUseCase.registerUser(AuthEntity(
          email: 'test@example.com',
          confirmPassword: 'password',
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwX30TYblQfkT6KQjErIsceWYu1ievYU1iIQ&usqp=CAU",
          password: 'password',
          firstName: 'Test1',
          lastName: 'User1',
        )),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockRegisterUseCase.registerUser(AuthEntity(
        email: 'test@example.com',
        confirmPassword: 'password',
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwX30TYblQfkT6KQjErIsceWYu1ievYU1iIQ&usqp=CAU",
        password: 'password',
        firstName: 'Test1',
        lastName: 'User1',
      ));

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });

    test('test signup with no credentials', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'Please enter email',
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockRegisterUseCase.registerUser(AuthEntity(
          email: 'null',
          confirmPassword: 'null',
          image: "null",
          password: 'null',
          firstName: 'null',
          lastName: 'null',
        )),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );
      // Call the login method
      final result = await mockRegisterUseCase.registerUser(AuthEntity(
        email: 'null',
        confirmPassword: 'null',
        image: "null",
        password: 'null',
        firstName: 'null',
        lastName: 'null',
      ));

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });
  });
}
