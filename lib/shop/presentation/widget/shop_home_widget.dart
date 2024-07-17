import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/shop/logic/product_provider.dart';
import 'package:jong/shop/presentation/widget/product_widget.dart';
import 'package:provider/provider.dart';

class ShopHomeWidget extends StatefulWidget {
  const ShopHomeWidget({super.key});

  @override
  State<ShopHomeWidget> createState() => _ShopHomeWidgetState();
}

class _ShopHomeWidgetState extends State<ShopHomeWidget> {
  @override
  Widget build(BuildContext context) {
    final instance = context.read<ProductProvider>();
    print("dada ${instance.listProductModel.length}");
    print("dada ${instance.listProductModel[2].id}");
    print("dada ${instance.listProductModel[2].name}");
    print("dada ${instance.listProductModel[2].createdAt}");
    print("dada ${instance.listProductModel[2].price}");

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: padding16,
          right: padding16,
          top: padding16,
          bottom: 180.h,
        ),
        child: Column(
          children: [
            Text(
              "Boissons disponibles",
              style: context.textTheme.headlineMedium?.copyWith(
                fontSize: 22,
              ),
            ),
            Gap(30.h),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemBuilder: (BuildContext contexxt, int _) {
                            print("a1");
                            return ProductWidget(
                              isShop: true,
                              id: "${instance.listProductModel[_].id}",
                              image: 'assets/images/1000.png',
                              title: instance.listProductModel[_].name!,
                              price: instance.listProductModel[_].price!,
                              quantity: 10,
                              // controller: controller['id'],
                            );
                          },
                          itemCount: instance.listProductModel.length)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
