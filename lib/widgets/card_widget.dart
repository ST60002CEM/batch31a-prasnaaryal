import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/constants/themes.dart';
import 'package:hamropasalmobile/controllers/itembag_controller.dart';
import 'package:hamropasalmobile/controllers/product_controller.dart';
import 'package:hamropasalmobile/model/product_model.dart';
import 'package:hamropasalmobile/views/detail_page.dart';

class ProductCardWidget extends ConsumerWidget {
  const ProductCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productNotifierProvider);
    return Container(
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      height: 300,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: product.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(product: product[index],)));
          },
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
                    child: Image.asset(product[index].imgUrl),
                  ),
                ),
                const Gap(4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product[index].title,
                        style: AppTheme.kCardTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(product[index].shortDescription,
                          style: AppTheme.kBodyText),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rs${product[index].price}',
                              style: AppTheme.kCardTitle),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(productNotifierProvider.notifier)
                                  .isSelectItem(product[index].pid, index);
          
                              if (product[index].isSelected == false) {
                                ref.read(itemBagProvider.notifier).addNewItemBag(
                                      ProductModel(
                                          pid: product[index].pid,
                                          imgUrl: product[index].imgUrl,
                                          title: product[index].title,
                                          price: product[index].price,
                                          shortDescription:
                                              product[index].shortDescription,
                                          longDescription:
                                              product[index].longDescription,
                                          review: product[index].review,
                                          rating: product[index].rating),
                                    );
                              } else {
                                ref
                                    .read(itemBagProvider.notifier)
                                    .removeItem(product[index].pid);
                              }
                            },
                            icon: Icon(
                              product[index].isSelected
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
          ),
        ),
      ),
    );
  }
}
