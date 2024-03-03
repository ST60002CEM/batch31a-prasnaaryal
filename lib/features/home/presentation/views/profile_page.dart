import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/features/home/presentation/home_view_model/home_view_model.dart';
import 'package:hamropasalmobile/features/home/presentation/state/home_state.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(homeViewModelProvider.notifier).getProfile();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final homeState = ref.watch(homeViewModelProvider);
    final profileData = homeState.userWrapper;
    ref.listen(homeViewModelProvider, (previous, next) {
      if (next.loggedOut ?? false) {
        Navigator.of(context).pushReplacementNamed('/login');
        setState(() {});
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Settings action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text('Avatar'),
                      trailing: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                profileData?.user.image ??
                                    ''), // Replace with your avatar image URL
                          ),
                          // Positioned(
                          //   bottom: 0,
                          //   right: 0,
                          //   child: Container(
                          //     padding: const EdgeInsets.all(2),
                          //     decoration: const BoxDecoration(
                          //       color: Colors.white,
                          //       shape: BoxShape.circle,
                          //     ),
                          //     child: const Icon(
                          //       Icons.edit,
                          //       size: 20,
                          //       color: Colors.purple,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('Name'),
                      subtitle: Text(
                          '${profileData?.user.firstName ?? ''} ${profileData?.user.lastName ?? ''}'),
                      // trailing: Icon(Icons.edit),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('Email'),
                      subtitle: Text(profileData?.user.email ?? ''),
                      // trailing: Icon(Icons.edit),
                    ),
                    const Divider(),
                    const ListTile(
                      title: Text('Change Password'),
                      trailing: Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                await ref.read(homeViewModelProvider.notifier).logOut();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
