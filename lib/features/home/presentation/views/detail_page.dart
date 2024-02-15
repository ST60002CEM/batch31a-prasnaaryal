import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/presentation/home_view_model/home_view_model.dart';

import '../../../../config/constants/themes.dart';

class DetailsPage extends ConsumerWidget {
  final ProductEntity productEntity;
  final List<CartEntity>? cartEntity;
  const DetailsPage({
    super.key,
    required this.productEntity,
    required this.cartEntity,
  });

  int _getCountInCart(
      ProductEntity productEntity, List<CartEntity>? cartEntity) {
    if (cartEntity == null || cartEntity.isEmpty) {
      return 0;
    }

    // Find the cartItem based on the productEntity
    var cartItem = cartEntity.firstWhere(
      (item) => item.productModel == productEntity,
      orElse: () => CartEntity(count: 0, productModel: productEntity),
    );

    return cartItem.count;
  }

  Widget _generateProductImage(String? image) {
    if (image == null) {
      return Container();
    }

    if (image.contains("http://") || image.contains("https://")) {
      return Image.network(image);
    }
    if (image.contains("data:image:") || image.contains("data:")) {
      Uint8List bytes = base64.decode(image.split(',').last);
      return Image.memory(bytes);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartEntity = ref.watch(homeViewModelProvider);
    int cartItem = _getCountInCart(productEntity, cartEntity.cartItems);

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
              child: _generateProductImage(productEntity.image),
            ),
            Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productEntity.name ?? "",
                      style: ThemeConstant.kBigTitle
                          .copyWith(color: kPrimaryColor),
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
                      productEntity.description ?? " ",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rs ${int.parse(productEntity.price ?? "0") * 1}',
                            style: ThemeConstant.kHeadingOne),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(homeViewModelProvider.notifier)
                                    .removeFromCart(productEntity);
                              },
                              icon: const Icon(Icons.do_not_disturb_on_outlined,
                                  size: 30),
                            ),
                            Text(cartItem.toString(),
                                style: ThemeConstant.kCardTitle
                                    .copyWith(fontSize: 24)),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(homeViewModelProvider.notifier)
                                    .addToCart(productEntity);
                              },
                              icon: const Icon(Icons.add_circle_outline,
                                  size: 30),
                            ),
                          ],
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
    );
  }
}
