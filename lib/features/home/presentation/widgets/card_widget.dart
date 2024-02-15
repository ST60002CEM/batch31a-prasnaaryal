import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/config/constants/themes.dart';
import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/presentation/home_view_model/home_view_model.dart';
import 'package:hamropasalmobile/features/home/presentation/views/detail_page.dart';

class ProductCardWidget extends ConsumerWidget {
  final ProductEntity product;
  final List<CartEntity> cartItes;
  const ProductCardWidget({
    super.key,
    required this.product,
    required this.cartItes,
  });

  Widget _generateProductImage(String? image) {
    if (image == null) {
      return Container();
    }

    if (image.contains("http://") || image.contains("https://")) {
      return Image.network(
        image,
        fit: BoxFit.cover,
      );
    }
    if (image.contains("data:image:") || image.contains("data:")) {
      Uint8List bytes = base64.decode(image.split(',').last);
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
      );
    }
    return Container();
  }

  CartEntity? _getCartEntity(ProductEntity productEntity) {
    if (cartItes
        .any((element) => element.productModel.sId == productEntity.sId)) {
      return cartItes.firstWhere(
          (element) => element.productModel.sId == productEntity.sId);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              productEntity: product,
              cartEntity: cartItes,
            ),
          ),
        );
      },
      child: SizedBox(
          width: 300,
          height: 300,
          child: Container(
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 6),
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2),
              ],
            ),
            margin: const EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(12),
                    color: kLightBackground,
                    child: _generateProductImage(product.image),
                  ),
                ),
                const Gap(4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? " ",
                        style: ThemeConstant.kCardTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(product.description ?? " ",
                          style: ThemeConstant.kBodyText),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rs${product.price}',
                              style: ThemeConstant.kCardTitle),
                          IconButton(
                            onPressed: () {
                              if (_getCartEntity(product) != null) {
                                ref
                                    .read(homeViewModelProvider.notifier)
                                    .removeFromCart(product);
                              } else {
                                ref
                                    .read(homeViewModelProvider.notifier)
                                    .addToCart(product);
                              }
                            },
                            icon: Icon(
                              _getCartEntity(product) != null
                                  ? Icons.check_circle
                                  : Icons.add_circle,
                              size: 30,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
