import 'package:flutter/material.dart';
import 'dart:async';
import 'package:all_sensors2/all_sensors2.dart';
import 'package:hamropasalmobile/config/router/app_route.dart';


class Sensor extends StatefulWidget {
  const Sensor({Key? key}) : super(key: key);

  @override
  _sensorState createState() => _sensorState();
}

class _sensorState extends State<Sensor> {
  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void initState() {
    bool initialEventProcessed = false;

    _streamSubscription.add(proximityEvents!.listen((event) {
      if (!initialEventProcessed) {
        initialEventProcessed = true;
        return;
      }

      setState(() {
        _proximityValue = event.proximity;
        if (_proximityValue >= 4) {
          _performLogout();
        }
      });
    }));

    super.initState();
  }

  @override
  void dispose() {
    for (var subscription in _streamSubscription) {
      subscription.cancel();
    }
    super.dispose();
  }

  void _performLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              // ref.read(homeViewModelProvider.notifier).signOut(context);
              Navigator.pushReplacementNamed(context, AppRoute.loginRoute);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            //   Navigator.pushReplacementNamed(context, AppRoute.dashboardRoute);
            // },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.homeRoute);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 60),
          child: Text('Profile'),
        ),
      ),
      body: Column(
        children: [
          // Your existing UI code here

          // Example UI components, replace with your own
          const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/images/logoo.png'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Sanjeela Thapa',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'sanjeelathapa@12gmail.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Perform logout logic if needed
                        // ref.read(homeViewModelProvider.notifier).signOut(context);
                        Navigator.pushReplacementNamed(
                            context, AppRoute.loginRoute);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(97, 124, 181, 1),
              minimumSize: const Size(150, 45),
              textStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0),
                  bottomLeft: Radius.circular(28.0),
                  bottomRight: Radius.circular(28.0),
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                buildProfileOption('Edit Profile', Icons.edit, () {
                  // Navigator.pushNamed(context, AppRoute.editprofileRoute);
                }),
                buildProfileOption(
                  'Citizen Verification',
                  Icons.verified_user,
                  () {
                    // Add your citizen verification functionality here
                    // For example, show citizen verification screen
                    // Navigator.pushNamed(context, AppRoute.citizenVerificationRoute);
                  },
                ),
                buildProfileOption('Billing Details', Icons.credit_card, () {
                  // Add your billing details functionality here
                  // For example, show billing details screen
                  // Navigator.pushNamed(context, AppRoute.billingDetailsRoute);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileOption(
      String title, IconData icon, VoidCallback onPressed) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      leading: Icon(icon),
      onTap: onPressed,
    );
  }
}
