import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/config/constants/themes.dart';
import 'package:hamropasalmobile/core/common/provider/theme_provider.dart';
import 'package:hamropasalmobile/features/home/presentation/home_view_model/home_view_model.dart';
import 'package:hamropasalmobile/features/home/presentation/views/cart_page.dart';
import 'package:hamropasalmobile/features/home/presentation/views/detail_page.dart';
import 'package:hamropasalmobile/features/home/presentation/views/favorite_page.dart';
import 'package:hamropasalmobile/features/home/presentation/widgets/ads_banner_widget.dart';
import 'package:hamropasalmobile/features/home/presentation/widgets/card_widget.dart';
import 'package:hamropasalmobile/features/home/presentation/widgets/chip_widget.dart';

import '../../../../config/router/app_route.dart';
import '../../../auth/presentation/view/login_view.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void initState() {
    bool initialEventProcessed = false;

    _streamSubscription.add(proximityEvents!.listen((event) {
      print('Proximity Event: ${event.proximity}');
      if (!initialEventProcessed) {
        initialEventProcessed = true;
        return;
      }

      setState(() {
        _proximityValue = event.proximity;
        if (_proximityValue >= 4) {
          _showLogoutConfirmation();
        }
      });
    }));

    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).getCategory();
      ref.read(homeViewModelProvider.notifier).getProduct();
      ref.read(homeViewModelProvider.notifier).getCartItems();
      ref.read(homeViewModelProvider.notifier).getFavoriteItems();
    });
  }

  @override
  void dispose() {
    for (var subscription in _streamSubscription) {
      subscription.cancel();
    }
    super.dispose();
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoute.loginRoute);
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
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    final categories = homeState.category?.categories;
    final products = homeState.products;
    final cartItems = homeState.cartItems;
    final favoriteItems = homeState.favoriteItems;

    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: SvgPicture.asset(
          'assets/general/store_brand_white.svg',
          colorFilter: const ColorFilter.mode(kWhiteColor, BlendMode.srcIn),
          width: 180,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                // Use Scaffold.of(context) within a Builder widget
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/menu.png',
                  fit: BoxFit.cover,
                  height: 15,
                  width: 15,
                  // Set your desired height
                  color: Colors.white, // Customize color if needed
                ),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: Badge(
              label: Text(cartItems?.length.toString() ?? "0"),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CardPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.local_mall,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                  SizedBox(height: 10),
                  //geeting widget
                  // GreetingWidget(),
                  // Text(
                  //   username ?? "",
                  //   style: TextStyle(fontSize: 20, color: Colors.white),
                  // ),
                  // SizedBox(height: 10),
                  // Text(
                  //   email ?? "",
                  //   style: TextStyle(fontSize: 20, color: Colors.white),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20),
            const Divider(
                thickness: 1, color: Color.fromARGB(255, 196, 196, 196)),
            ListTile(
              iconColor: const Color.fromARGB(255, 15, 6, 6),
              leading: const Icon(Icons.assignment_return_rounded),
              title: const Text('Refund & Return',
                  style: TextStyle(color: Color.fromARGB(255, 10, 7, 7))),
              onTap: () {
                // Navigator.pushNamed(context, MyRoutes.refundRoute);
              },
            ),
            ListTileTheme(
              dense: true,
              child: Consumer(
                builder: (context, ref, _) {
                  final themeMode = ref.watch(themeModeProvider);

                  return SwitchListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    value: themeMode == ThemeModeType.dark,
                    onChanged: (value) {
                      // Toggle theme mode when the switch is pressed
                      ref.read(themeModeProvider.notifier).toggleTheme();
                    },
                    title: const Text(
                      'Dark Mode',
                      style: TextStyle(color: Color.fromARGB(255, 11, 0, 0)),
                    ),
                    secondary: Icon(Icons.sunny),
                    activeColor: Colors.black,
                    inactiveTrackColor: Colors.grey.withOpacity(0.5),
                    activeTrackColor: Colors.black.withOpacity(0.5),
                    activeThumbImage: AssetImage('assets/images/moon.jpg'),
                    inactiveThumbImage: AssetImage('assets/images/sun.jpg'),
                  );
                },
              ),
            ),
            ListTile(
              iconColor: Colors.black,
              leading: const Icon(Icons.question_answer),
              title: const Text('Review',
                  style: TextStyle(color: Color.fromARGB(255, 13, 3, 3))),
              onTap: () {
                Navigator.pushNamed(context, AppRoute.favRoute);
              },
            ),
            ListTile(
              iconColor: Colors.black,
              leading: const Icon(Icons.help_outline),
              title: const Text('Help Center',
                  style: TextStyle(color: Color.fromARGB(255, 15, 2, 2))),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Help Center'),
                        content: const Text('No Help Center Available'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              },
            ),
            ListTile(
              iconColor: Colors.black,
              leading: const Icon(Icons.logout_outlined),
              title:
                  const Text('Logout', style: TextStyle(color: Colors.black)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("You pressed Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('yes'),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => LoginView()));
                        },
                      ),
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              // Ads banner section
              const AdsBannerWidget(),
              // Chip section
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories?.length ?? 0,
                  itemBuilder: (context, index) =>
                      ChipWidget(chipLabel: categories![index].toString()),
                ),
              ),
              // Hot Sales section
              const Gap(12),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hot Sales', style: ThemeConstant.kHeadingOne),
                  Text('See all', style: ThemeConstant.kSeeAllText),
                ],
              ),
              const Gap(12),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: products?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ProductCardWidget(
                    product: products![index],
                    cartItes: cartItems ?? [],
                    favoriteItes: favoriteItems ?? [],
                  ),
                ),
              ),

              // Featured section
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured Products', style: ThemeConstant.kHeadingOne),
                  Text('See all', style: ThemeConstant.kSeeAllText),
                ],
              ),
              MasonryGridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products?.length ?? 0,
                shrinkWrap: true,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        productEntity: products[index],
                        cartEntity: cartItems,
                        favoriteEntity: favoriteItems,
                      ),
                    ),
                  ),
                  child: ProductCardWidget(
                    product: products![index],
                    cartItes: cartItems ?? [],
                    favoriteItes: favoriteItems ?? [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
