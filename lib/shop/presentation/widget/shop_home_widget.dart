import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/shop/logic/courter_model.dart';
import 'package:jong/shop/presentation/widget/product_widget.dart';
import 'package:provider/provider.dart';

class ShopHomeWidget extends StatelessWidget {
  const ShopHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final instance = context.read<CounterModel>();
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
                            return ProductWidget(
                              id: instance.articles['items'][_]['id'],
                              isShop: false,
                              image: 'assets/images/1000.png',
                              title: instance.articles['items'][_]['title'],
                              quantity: instance.articles['items'][_]
                                  ['quantity'],
                              price: instance.articles['items'][_]['price'],
                            );
                          },
                          itemCount: instance.articles['items'].length)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}