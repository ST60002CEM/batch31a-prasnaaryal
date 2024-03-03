import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hamropasalmobile/features/home/domain/entity/cart_entity.dart';
import 'package:hamropasalmobile/features/home/domain/entity/product_entity.dart';
import 'package:hamropasalmobile/features/home/presentation/home_view_model/home_view_model.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shake/shake.dart';

import '../../../../config/constants/themes.dart';
import '../../domain/use_case/controllers/itembag_controller.dart';

class CardPage extends ConsumerWidget {
  const CardPage({super.key});

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

  double _calculateTotal(List<CartEntity>? cartItems) {
    if (cartItems == null) {
      return 0.0;
    }
    // Use fold to sum up the total value of items in the cart
    double total = cartItems.fold(0, (sum, item) {
      return sum + (int.parse(item.productModel.price ?? "0") * item.count);
    });

    return total;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeProvider = ref.watch(homeViewModelProvider);
    final cartItems = homeProvider.cartItems;
    double totalValue = _calculateTotal(cartItems);

    // Add ShakeDetector to listen for phone shake
    // ShakeDetector detector = ShakeDetector.autoStart(
ShakeDetector detector = ShakeDetector.autoStart(
  onPhoneShake: () async {
    // Remove an item from the cart when phone is shaken
    if (cartItems != null && cartItems.isNotEmpty) {
      var lastItem = cartItems.last; // 'var' or the correct type for a cart item

      // Instead of casting, check the type
      if (lastItem is ProductEntity) {
        // If lastItem is a ProductEntity, it's safe to use it as one
        ProductEntity productEntity = lastItem.productModel;

        // Proceed to remove the product from the cart
        await ref
            .read(homeViewModelProvider.notifier)
            .removeFromCart(productEntity);
      } else if (lastItem is CartEntity) {
        // If it's a CartEntity, handle that case here
        CartEntity cartEntity = lastItem;
        // You need to implement logic to handle a CartEntity
        // For example, if you need to convert it to a ProductEntity or handle differently
        // ...
      } else {
        // Handle any other types, or do nothing if lastItem is expected to be only these types
        print('Last item is neither ProductEntity nor CartEntity');
      }
    }
  },
  shakeSlopTimeMS: 500,
  shakeCountResetTime: 3000,
  shakeThresholdGravity: 2.7,
);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'MyCart Page',
          style: ThemeConstant.kBigTitle.copyWith(color: kWhiteColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.local_mall),
            ),
          )
        ],
      ),
      body: Column(children: [
        Expanded(
          flex: 2,
          child: Container(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: cartItems?.length ?? 0,
                itemBuilder: (context, index) => Card(
                  child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: _generateProductImage(
                                cartItems?[index].productModel.image),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      cartItems?[index].productModel.name ?? "",
                                      style: ThemeConstant.kCardTitle),
                                  const Gap(6),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                        cartItems?[index].count.toString() ??
                                            "",
                                        style: ThemeConstant.kBodyText),
                                  ),
                                  const Gap(4),
                                  Text(
                                    'Rs ${cartItems?[index].productModel.price}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.cyan),
                            onPressed: () {
                              ref
                                  .read(homeViewModelProvider.notifier)
                                  .removeFromCart(
                                      cartItems![index].productModel);
                            },
                          ),
                        ],
                      )),
                ),
              )),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Fee:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Free',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'No discount',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      Text(
                        totalValue.toString(),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: KhaltiButton(
                      config: PaymentConfig(
                        amount: totalValue.toInt() *
                            100, // Amount should be in paisa
                        productIdentity: 'dell-g5-g5510-2021',
                        productName: 'Dell G5 G5510 2021',
                        productUrl: 'https://www.khalti.com/#/bazaar',
                        additionalData: {
                          // Not mandatory; can be used for reporting purpose
                          'vendor': 'Khalti Bazaar',
                        },
                        mobile:
                            '9800000001', // Not mandatory; can be used to fill mobile number field
                        mobileReadOnly:
                            true, // Not mandatory; makes the mobile field not editable
                      ),
                      preferences: [
                        // Not providing this will enable all the payment methods.
                        PaymentPreference.khalti,
                        PaymentPreference.eBanking,
                      ],
                      onSuccess: (successModel) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Payment Done'),
                          ),
                        ); // Perform Server Verification
                      },
                      onFailure: (failureModel) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Payment Failed'),
                          ),
                        ); //
                        // What to do on failure?
                      },
                      onCancel: () {
                        // User manually cancelled the transaction
                      },
                    ),
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}
