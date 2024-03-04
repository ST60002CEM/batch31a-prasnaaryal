import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';
import 'package:hamropasalmobile/features/auth/domain/use_case/login_usecase.dart';
import 'package:hamropasalmobile/features/auth/domain/use_case/register_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LoginUseCase>(),
  MockSpec<BuildContext>(),

])

void main(){
    late MockLoginUseCase mockLoginUseCase;
    late AuthEntity mockAuthEntity;


    setUpAll(() async {
    mockLoginUseCase = MockLoginUseCase();
  });

    group('test login', () {
    setUpAll(() async {
      /// Creating a proper mock user for loggin in
      mockAuthEntity = AuthEntity(
        email: 'test@example.com',
        userId: '1234567890',
        password: 'password',
        confirmPassword: 'password',
        firstName: 'Test',
        lastName: 'User',
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwX30TYblQfkT6KQjErIsceWYu1ievYU1iIQ&usqp=CAU"
      );

      /// if provided certain credential returen the proper mock user
      when(
        mockLoginUseCase.loginUser(
          'test@example.com',
          'password',
        ),
      ).thenAnswer(
  (_) async => Right<Failure, String>(mockAuthEntity.userId ?? ''),
      );
    });
    });

 test('test login with proper credentials', () async {
      // Call the login method
      final result = await mockLoginUseCase.loginUser(
        'test@example.com',
        'password',
      );

      // Verify the expected result
  expect(result, Right<Failure, String>(mockAuthEntity.userId ?? ''));
    });


       test('test login with invalid email', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'User with email not found',
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockLoginUseCase.loginUser(
          'test22@example.com',
          'password',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockLoginUseCase.loginUser(
        'test22@example.com',
        'password',
      );

      // Verify the expected result
      expect(result, Left(mockErrorModel));
    });


      test('test login with invalid password', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'Invalid Password',
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockLoginUseCase.loginUser(
          'test@example.com',
          'password000',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockLoginUseCase.loginUser(
        'test@example.com',
        'password000',
      );

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });


      test('test login with null email', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'Please enter email',
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockLoginUseCase.loginUser(
          null,
          'password',
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockLoginUseCase.loginUser(
        null,
        'password',
      );

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });



     test('test login with null password', () async {
      /// Creating a proper mock failure for failed login with invalid email
      final mockErrorModel = Failure(
        error: 'Please enter password',
      );

      /// if provided certain credential returen the mockErrorModel
      when(
        mockLoginUseCase.loginUser(
          'test@example.com',
          null,
        ),
      ).thenAnswer(
        (_) async => Left(mockErrorModel),
      );

      // Call the login method
      final result = await mockLoginUseCase.loginUser(
        'test@example.com',
        null,
      );

      // Verify the expected result
      expect(
        result,
        Left(mockErrorModel),
      );
    });
  }




