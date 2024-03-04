import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/config/router/app_route.dart';
import 'package:hamropasalmobile/core/common/snackbar/my_snackbar.dart';
import 'package:hamropasalmobile/features/auth/presentation/auth_viewmodel/auth_viewmodel.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'prasnaworks@gmail.com');
  final _passwordController = TextEditingController(text: 'Password123\$');

  final _gap = const SizedBox(height: 8);
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    // TODO: Add loading and disable button while loading
    final authState = ref.watch(authViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authState.showMessage! && authState.error != null) {
        showSnackBar(message: authState.error.toString(), context: context);
        ref.read(authViewModelProvider.notifier).resetMessage();
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add your logo here
                    Image.asset(
                      'assets/images/logo.png', // Replace with the path to your logo image
                      width: 150, // Adjust the width as needed
                      height: 150, // Adjust the height as needed
                    ),
                    _gap,
                    TextFormField(
                      key: const ValueKey('username'),
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                          size: 22.0,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      key: const ValueKey('password'),
                      controller: _passwordController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 22.0,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      }),
                    ),
                    _gap,
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .loginUser(
                                context,
                                _emailController.text,
                                _passwordController.text,
                              );
                        }
                        Navigator.pushNamed(context, AppRoute.homeRoute);
                      },
                      child: const SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Gap(8),
                    GestureDetector(
                      key: const ValueKey('registerButton'),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoute.registerRoute);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Dont have an account ? ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontFamily: 'Brand Bold',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
