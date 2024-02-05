import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/core/common/snackbar/my_snackbar.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';
import 'package:hamropasalmobile/features/auth/presentation/auth_viewmodel/auth_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gap/gap.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _gap = const SizedBox(height: 10);

  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: 'Kiran');
  final _lnameController = TextEditingController(text: 'Rana');
  final _emailController = TextEditingController(text: '9812345678');
  final _confirmpasswordController = TextEditingController(text: 'kiran');
  final _passwordController = TextEditingController(text: 'kiran123');

  bool isObscure = true;

  // Check for the camera permission
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        _img = File(image.path);
        ref.read(authViewModelProvider.notifier).uploadImage(_img!);
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final batchState = ref.watch(batchViewModelProvider);
    // final courseState = ref.watch(courseViewModelProvider);
    // final isConnected = ref.watch(connectivityStatusProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (isConnected == ConnectivityStatus.isDisconnected) {
      //   showSnackBar(
      //       message: 'No Internet Connection',
      //       context: context,
      //       color: Colors.red);
      // } else if (isConnected == ConnectivityStatus.isConnected) {
      //   showSnackBar(message: 'You are online', context: context);
      // }

      if (ref.watch(authViewModelProvider).showMessage!) {
        showSnackBar(
            message: 'Student Registerd Successfully', context: context);
        ref.read(authViewModelProvider.notifier).resetMessage();
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Set your border color here
                    width: 1.0, // Set your border width here
                  ),
                  borderRadius: BorderRadius.circular(
                      10.0), // Set your border radius here
                ),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey[300],
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      checkCameraPermission();
                                      _browseImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _browseImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text('Gallery'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          // Adjust the padding value as needed

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 50,
                              // backgroundImage:
                              //     AssetImage('assets/images/profile.png'),
                              backgroundImage: _img != null
                                  ? FileImage(_img!)
                                  : const AssetImage('assets/images/avatar.png')
                                      as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height:
                              20), // Add space between CircleAvatar and next widget

                      Container(
                        width: 330, // Set your desired width here
                        child: TextFormField(
                          controller: _fnameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          }),
                        ),
                      ),
                      Gap(10),

                      Container(
                        width: 330, // Set your desired width here
                        child: TextFormField(
                          controller: _lnameController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          }),
                        ),
                      ),
                      Gap(10),
                      Container(
                        width: 330, // Set your desired width here
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          }),
                        ),
                      ),
                      Gap(10),
                      // batchState.isLoading
                      //     ? const Center(child: CircularProgressIndicator())
                      //     : DropdownButtonFormField(
                      //         hint: const Text('Select batch'),
                      //         items: batchState.batches
                      //             .map(
                      //               (batch) => DropdownMenuItem<BatchEntity>(
                      //                 value: batch,
                      //                 child: Text(batch.batchName),
                      //               ),
                      //             )
                      //             .toList(),
                      //         onChanged: (value) {
                      //           selectedBatch = value;
                      //         },
                      //         decoration: const InputDecoration(
                      //           labelText: 'Select Batch',
                      //         ),
                      //       ),
                      // _gap,
                      // courseState.isLoading
                      //     ? const Center(
                      //         child: CircularProgressIndicator(),
                      //       )
                      //     : MultiSelectDialogField(
                      //         title: const Text('Select course(s)'),
                      //         items: courseState.courses
                      //             .map(
                      //               (course) => MultiSelectItem(
                      //                 course,
                      //                 course.courseName,
                      //               ),
                      //             )
                      //             .toList(),
                      //         listType: MultiSelectListType.CHIP,
                      //         buttonText: const Text('Select course(s)'),
                      //         buttonIcon: const Icon(Icons.search),
                      //         onConfirm: (values) {
                      //           _lstCourseSelected.clear();
                      //           _lstCourseSelected.addAll(values);
                      //         },
                      //         decoration: BoxDecoration(
                      //           border: Border.all(
                      //             color: Colors.grey,
                      //           ),
                      //           borderRadius: BorderRadius.circular(5),
                      //         ),
                      //         validator: ((value) {
                      //           if (value == null || value.isEmpty) {
                      //             return 'Please select courses';
                      //           }
                      //           return null;
                      //         }),
                      //       ),

                      Container(
                        width: 330, // Set your desired width here
                        child: TextFormField(
                          controller: _confirmpasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          }),
                        ),
                      ),
                      Gap(10),
                      Container(
                        width: 330, // Set your desired width here
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            labelText: ' Confirm Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
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
                      ),
                      Gap(20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              final entity = AuthEntity(
                                firstName: _fnameController.text.trim(),
                                lastName: _lnameController.text.trim(),
                                email: _emailController.text.trim(),
                                image:
                                    ref.read(authViewModelProvider).imageName ??
                                        '',
                                confirmPassword:
                                    _confirmpasswordController.text,
                                password: _passwordController.text,
                              );
                              // Register user
                              ref
                                  .read(authViewModelProvider.notifier)
                                  .registerUser(entity);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minimumSize: const Size(300, 50)),
                          child: const Text('Register'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
