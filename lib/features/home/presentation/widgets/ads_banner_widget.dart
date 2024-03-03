import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';

import '../../../../config/constants/themes.dart';

class AdsBannerWidget extends StatelessWidget {
  const AdsBannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> bannerImageUrls = [
      'assets/images/banner.jpg', // Replace with your banner image URLs
      'assets/images/banner.jpg',
      'assets/images/banner.png',
    ];

    return CarouselSlider.builder(
      itemCount: bannerImageUrls.length,
      options: CarouselOptions(
        height: 170,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIndex) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bannerImageUrls[index]),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          //   child: Container(
          //     padding: const EdgeInsets.only(left: 20),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         const Text(
          //           'Apple Store',
          //           style: ThemeConstant.kBigTitle,
          //         ),
          //         const Gap(8),
          //         Text(
          //           'Find the Apple product and accessories you’re looking for',
          //           style: ThemeConstant.kBodyText.copyWith(color: kWhiteColor),
          //         ),
          //         const Gap(4),
          //         ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(5),
          //             ),
          //             backgroundColor: kWhiteColor,
          //             foregroundColor: kSecondaryColor,
          //           ),
          //           onPressed: () {},
          //           child: const Text('Shop new year'),
          //         ),
          //       ],
          //     ),
          //   ),
        );
      },
    );
  }
}
