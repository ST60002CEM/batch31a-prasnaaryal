import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hamropasalmobile/constants/themes.dart';
import 'package:hamropasalmobile/widgets/ads_banner_widget.dart';
import 'package:hamropasalmobile/widgets/chip_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: SvgPicture.asset(
            'assets/general/store_brand_white.svg',
            colorFilter: ColorFilter.mode(kWhiteColor, BlendMode.srcIn),
            width: 180,
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.local_mall_outlined)))
          ],
          leading: IconButton(
            onPressed: () async {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        drawer: const Drawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                // Ads banner section
                AdsBannerWidget(),
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
                )
                // Hot Sales section
                // Featured section
              ],
            ),
          ),
        ));
  }
}
