import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hamropasalmobile/features/home/presentation/home_view_model/home_view_model.dart';
import 'package:hamropasalmobile/features/home/presentation/views/sensor_screen.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../../config/constants/themes.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/use_case/controllers/itembag_controller.dart';

class FavoritePage extends ConsumerWidget {

  const FavoritePage({
    super.key,
  });

  Widget _generateProductImage(String? image) {
    if (image == null) {
      return Container();
    }

    if (image.contains("http://") || image.contains("https://")) {
      return Image.network(
        image,
        height: 80,
        width: 80,
        fit: BoxFit.cover,
      );
    }
    if (image.contains("data:image:") || image.contains("data:")) {
      Uint8List bytes = base64.decode(image.split(',').last);
      return Image.memory(
        bytes,
        height: 80,
        width: 80,
        fit: BoxFit.cover,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeProvider = ref.watch(homeViewModelProvider);
    final favoriteItems = homeProvider.favoriteItems;

// [MagnetometerEvent (x: -23.6, y: 6.2, z: -34.9)]

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Favorite',
          style: ThemeConstant.kBigTitle.copyWith(color: kWhiteColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
          )
        ],
      ),
      body: Column(children: [
        const SizedBox(height: 200, child: Sensor()),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: favoriteItems?.length ?? 0,
              itemBuilder: (context, index) => Card(
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _generateProductImage(
                            favoriteItems?[index].productModel.image),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  favoriteItems?[index].productModel.name ?? "",
                                  style: ThemeConstant.kCardTitle),
                              const Gap(6),
                              Text(
                                  favoriteItems?[index]
                                          .productModel
                                          .description ??
                                      "",
                                  style: ThemeConstant.kBodyText),
                              const Gap(4),
                              Text(
                                'Rs ${favoriteItems?[index].productModel.price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.cyan),
                        onPressed: () {
                          ref
                              .read(homeViewModelProvider.notifier)
                              .removeFromFavorite(favoriteItems![index].productModel);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
