import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/config/themes/themes.dart';
import 'package:hamropasalmobile/controllers/product_controller.dart';

class ProductCardWidget extends ConsumerWidget {
  const ProductCardWidget({
    super.key,
    required this.productIndex,
  });

  final int productIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productNotifierProvider);
    return Container(
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      height: 300,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
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
                  child: Image.asset(product[productIndex].imgUrl),
                ),
              ),
              const Gap(4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product[productIndex].title,
                      style: AppTheme.kCardTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(product[productIndex].shortDescription,
                        style: AppTheme.kBodyText),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rs${product[productIndex].price}',
                            style: AppTheme.kCardTitle),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_circle,
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
        ),
      ),
    );
  }
}
