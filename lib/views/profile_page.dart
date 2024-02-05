import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Settings action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Avatar'),
                  trailing: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'Your image URL here'), // Replace with your avatar image URL
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text('pp@pp.com'),
                  trailing: Icon(Icons.edit),
                ),
                Divider(),
                ListTile(
                  title: Text('Change Password'),
                  trailing: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
