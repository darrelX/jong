import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/utils/const.dart';

import 'preview_widget.dart';
import 'product_widget.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          const PreviewWidget(
            padding: EdgeInsets.zero,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: padding24),
              children: const [
                ProductWidget(
                  image: 'assets/images/500.png',
                  title: "Boisson de 500",
                  price: '500',
                  isInCart: true,
                ),
                Gap(20),
                ProductWidget(
                  image: 'assets/images/1000.png',
                  title: "Boisson de 650",
                  price: '650',
                  isInCart: true,
                ),
                Gap(20),
                ProductWidget(
                  image: 'assets/images/1000.png',
                  title: "Boisson de 700",
                  price: '700',
                  isInCart: true,
                ),
                Gap(20),
                ProductWidget(
                  image: 'assets/images/1000.png',
                  title: "Boisson de 1000",
                  price: '1000',
                  isInCart: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
