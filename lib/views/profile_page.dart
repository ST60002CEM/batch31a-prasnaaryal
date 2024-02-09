import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamropasalmobile/constants/themes.dart';
import 'package:hamropasalmobile/controllers/itembag_controller.dart';
import 'package:hamropasalmobile/core/common/widget/Bottom_navigation.dart';
import 'package:hamropasalmobile/views/home_page.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final itemBag = ref.watch(itemBagProvider);
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Profile',
          style: AppTheme.kBigTitle.copyWith(color: kWhiteColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.local_mall_outlined),
            ),
          )
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
      bottomNavigationBar: CustomBottomNavigationBar(),

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   onTap: (value) {
      //     ref.read(currentIndexProvider.notifier).update((state) => value);

      //     switch (value) {
      //       case 0:
      //         // Home icon index
      //         // Scroll to the top of the page

      //         // After scrolling to the top, use Navigator.push to navigate to the HomePage
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => HomePage(),
      //           ),
      //         );

      //         break;
      //       case 4:
      //         // Profile icon index
      //         // Use Navigator.push to navigate to the DetailsPage
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => SettingsScreen(),
      //           ),
      //         );
      //         break;
      //       default:
      //         ref.read(currentIndexProvider.notifier).update((state) => value);
      //         // Handle other tabs if needed
      //         break;
      //     }
      //   },
      //   selectedItemColor: kPrimaryColor,
      //   unselectedItemColor: kSecondaryColor,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //       activeIcon: Icon(Icons.home_filled),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite_outline),
      //       label: 'Favorite',
      //       activeIcon: Icon(Icons.favorite),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.location_on_outlined),
      //       label: 'Location',
      //       activeIcon: Icon(Icons.location_on),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications_outlined),
      //       label: 'Notification',
      //       activeIcon: Icon(Icons.notifications),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_outline),
      //       label: 'Profile',
      //       activeIcon: Icon(Icons.person),
      //     ),
      //   ],
      // ),
    );
  }
}
