import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/config/constants/themes.dart';
import 'package:hamropasalmobile/features/home/presentation/home_view_model/home_view_model.dart';
import 'package:hamropasalmobile/features/home/presentation/views/detail_page.dart';
import 'package:hamropasalmobile/features/home/presentation/widgets/ads_banner_widget.dart';
import 'package:hamropasalmobile/features/home/presentation/widgets/card_widget.dart';
import 'package:hamropasalmobile/features/home/presentation/widgets/chip_widget.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).getCategory();
      ref.read(homeViewModelProvider.notifier).getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final products = ref.watch(productNotifierProvider);
    // final currentIndex = ref.watch(currentIndexProvider);
    // final itemBag = ref.watch(itemBagProvider);

    final homeState = ref.watch(homeViewModelProvider);
    final categories = homeState.category?.categories;
    final products = homeState.products;

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
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 20, top: 10),
          //   child: Badge(
          //     label: Text(itemBag.length.toString()),
          //     child: IconButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const CardPage(),
          //           ),
          //         );
          //       },
          //       icon: const Icon(
          //         Icons.local_mall,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      drawer: const Drawer(),
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    ...categories
                            ?.map((c) => ChipWidget(chipLabel: c.toString()))
                            .toList() ??
                        [],
                    // ChipWidget(
                    //   chipLabel: 'All',
                    // ),
                    // ChipWidget(
                    //   chipLabel: 'Computers',
                    // ),
                    // ChipWidget(
                    //   chipLabel: 'Headsets',
                    // ),
                    // ChipWidget(
                    //   chipLabel: 'Accessories',
                    // ),
                    // ChipWidget(
                    //   chipLabel: 'Printing',
                    // ),
                    // ChipWidget(
                    //   chipLabel: 'Gamers',
                    // )
                  ],
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
              ...products?.map((e) => Text(e.name ?? "")).toList() ?? []

              // Container(
              //   padding: const EdgeInsets.all(4),
              //   width: double.infinity,
              //   height: 300,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(4),
              //     itemCount: 4,
              //     scrollDirection: Axis.horizontal,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) =>
              //         ProductCardWidget(productIndex: index),
              //   ),
              // ),
              // const ProductCardWidget(productIndex: 5),
              // // Featured section
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('Featured Products', style: ThemeConstant.kHeadingOne),
              //     Text('See all', style: ThemeConstant.kSeeAllText),
              //   ],
              // ),

              // MasonryGridView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: homeState.products?.length ?? 0,
              //   shrinkWrap: true,
              //   gridDelegate:
              //       const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2),
              //   itemBuilder: (context, index) => GestureDetector(
              //     onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => DetailsPage(
              //           getIndex: index,
              //         ),
              //       ),
              //     ),
              //     child: SizedBox(
              //       height: 250,
              //       child: ProductCardWidget(
              //         productIndex: index,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   onTap: (value) {
      //     if (value == 0) {
      //       // Home icon index
      //       // Scroll to the top of the page
      //       scrollController.animateTo(
      //         0,
      //         duration: const Duration(milliseconds: 500),
      //         curve: Curves.easeInOut,
      //       );
      //     } else {
      //       ref.read(currentIndexProvider.notifier).update((state) => value);
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
