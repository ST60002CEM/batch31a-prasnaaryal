// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hamropasalmobile/config/router/app_route.dart';
// import 'package:hamropasalmobile/config/themes/app_theme.dart';
// import 'package:hamropasalmobile/core/failure/failure.dart';
// import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';
// import 'package:hamropasalmobile/features/auth/domain/use_case/auth_status_usecase.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:hamropasalmobile/core/app.dart';
// import '../test/auth/login_unit_test.mocks.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   TestWidgetsFlutterBinding.ensureInitialized();

//   late MockLoginUseCase mockLoginUseCase;
//   late AuthEntity mockAuthEntity;

//   setUpAll(() async {
//     mockLoginUseCase = MockLoginUseCase();
//   });

//   group('test login', () {
//     setUpAll(() async {
//       /// Creating a proper mock user for loggin in
//       mockAuthEntity = AuthEntity(
//         email: 'test@example.com',
//         confirmPassword: 'password',
//         image:const (
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwX30TYblQfkT6KQjErIsceWYu1ievYU1iIQ&usqp=CAU"),
//         password: 'password',
//         firstName: 'Test1',
//         lastName: 'User1',
//       );

//       /// if provided certain credential returen the proper mock user
//       when(
//         mockLoginUseCase.loginUser(
//           'test@example.com',
//           'password',
//         ),
//       ).thenAnswer(
//         (_) async => Right<Failure, String>(mockAuthEntity.userId ?? ''),
//       );
//     });

//     testWidgets('test login with wrong email', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         ProviderScope(
//           child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Student App',
//             home:const App(), // Replace with your App widget
//           ),
//         ),
//       );

//       await tester.pumpAndSettle();

//       await tester.enterText(
//         find
//             .byType(
//               TextFormField,
//             )
//             .at(0),
//         'test',
//       );

//       await tester.enterText(
//         find
//             .byType(
//               TextFormField,
//             )
//             .at(1),
//         'password',
//       );

//       await tester.tap(
//         find.widgetWithText(
//           ElevatedButton,
//           '     Login     ',
//         ),
//       );

//       await tester.pumpAndSettle(const Duration(seconds: 1));

//       expect(
//         find.text('LOGIN', findRichText: true),
//         findsOneWidget,
//       );
//     });
//   });
// }
