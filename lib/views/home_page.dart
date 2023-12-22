import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/constants/themes.dart';
import 'package:hamropasalmobile/widgets/ads_banner_widget.dart';
import 'package:hamropasalmobile/widgets/card_widget.dart';
import 'package:hamropasalmobile/widgets/chip_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.local_mall_outlined),
            ),
          )
        ],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
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
                  children: const [
                    ChipWidget(
                      chipLabel: 'All',
                    ),
                    ChipWidget(
                      chipLabel: 'Computers',
                    ),
                    ChipWidget(
                      chipLabel: 'Headsets',
                    ),
                    ChipWidget(
                      chipLabel: 'Accessories',
                    ),
                    ChipWidget(
                      chipLabel: 'Printing',
                    ),
                    ChipWidget(
                      chipLabel: 'Gamers',
                    )
                  ],
                ),
              ),
              // Hot Sales section
              const Gap(12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hot Sales', style: AppTheme.kHeadingOne),
                  Text('See all', style: AppTheme.kSeeAllText),
                ],
              ),
              const ProductCardWidget()
              // Featured section
            ],
          ),
        ),
      ),
    );
  }
}
