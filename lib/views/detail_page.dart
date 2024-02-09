import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/controllers/product_controller.dart';
import 'package:hamropasalmobile/views/home_page.dart';

import '../config/constants/themes.dart';

class DetailsPage extends ConsumerWidget {
  DetailsPage({super.key, required this.getIndex});

  int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final product = ref.watch(productNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Details Page',
          style: ThemeConstant.kBigTitle.copyWith(color: kWhiteColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.local_mall_outlined),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: kLightBackground,
              child: Image.asset(product[getIndex].imgUrl),
            ),
            Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product[getIndex].title,
                      style: ThemeConstant.kBigTitle.copyWith(color: kPrimaryColor),
                    ),
                    const Gap(12),
                    Row(
                      children: [
                        RatingBar(
                          itemSize: 25,
                          initialRating: 1,
                          minRating: 1,
                          maxRating: 5,
                          allowHalfRating: true,
                          ratingWidget: RatingWidget(
                            empty: const Icon(Icons.star_border,
                                color: Colors.amber),
                            full: const Icon(Icons.star, color: Colors.amber),
                            half: const Icon(Icons.star_half_sharp,
                                color: Colors.amber),
                          ),
                          onRatingUpdate: (value) {},
                        ),
                        const Gap(12),
                        const Text('123 reviews'),
                      ],
                    ),
                    const Gap(8),
                    Text(
                      product[getIndex].longDescription,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Rs ${product[getIndex].price * product[getIndex].qty}',
                            style: ThemeConstant.kHeadingOne),
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(productNotifierProvider.notifier)
                                      .decreaseQty(product[getIndex].pid);
                                },
                                icon: const Icon(
                                    Icons.do_not_disturb_on_outlined,
                                    size: 30),
                              ),
                              Text(product[getIndex].qty.toString(),
                                  style: ThemeConstant.kCardTitle
                                      .copyWith(fontSize: 24)),
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(productNotifierProvider.notifier)
                                      .incrementQty(product[getIndex].pid);
                                },
                                icon: const Icon(Icons.add_circle_outline,
                                    size: 30),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: kWhiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: const Size(double.infinity, 50)),
                      onPressed: () {},
                      child: const Text('Add to cart'),
                    ),
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) =>
            ref.read(currentIndexProvider.notifier).update((state) => value),
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kSecondaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
            activeIcon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Location',
            activeIcon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notification',
            activeIcon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
