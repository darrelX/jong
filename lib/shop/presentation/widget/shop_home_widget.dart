import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/shop/presentation/widget/product_widget.dart';

class ShopHomeWidget extends StatelessWidget {
  const ShopHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
          left: padding16,
          right: padding16,
          top: padding16,
          bottom: 180.h,
        ),
        children: [
          Text(
            "boisson disponible",
            style: context.textTheme.headlineMedium?.copyWith(
              fontSize: 22,
            ),
          ),
          Gap(30.h),
          const ProductWidget(
            image: 'assets/images/500.png',
            title: "Boisson de 500",
            price: '500',
          ),
          const Gap(20),
          const ProductWidget(
            image: 'assets/images/1000.png',
            title: "Boisson de 650",
            price: '650',
          ),
          const Gap(20),
          const ProductWidget(
            image: 'assets/images/1000.png',
            title: "Boisson de 700",
            price: '700',
          ),
          const Gap(20),
          const ProductWidget(
            image: 'assets/images/1000.png',
            title: "Boisson de 1000",
            price: '1000',
          ),
        ],
      ),
    );
  }
}
