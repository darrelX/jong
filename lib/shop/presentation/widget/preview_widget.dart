import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/widget/app_dialog.dart';
import 'package:jong/shop/logic/product_provider.dart';
import 'package:jong/shop/presentation/widget/checkout_widget.dart';
import 'package:provider/provider.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/const.dart';

class PreviewWidget extends StatelessWidget {
  const PreviewWidget({
    super.key,
    this.padding = const EdgeInsets.all(padding16),
  });
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final instance = context.read<ProductProvider>();

    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius20),
          topRight: Radius.circular(radius20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 20.h,
              ),
              child: Container(
                height: 10.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Text(
            "Total price",
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(20),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${instance.getTotalPrice()}',
                    style: context.textTheme.displaySmall?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    "nkap",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius20 - 1),
                ),
                onTap: () {
                  instance.getBasketItems();
                  AppDialog.showDialog(
                    context: context,
                    height: 300,
                    child: const Padding(
                      padding: EdgeInsets.all(padding16),
                      child: CheckoutWidget(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(radius20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: padding24,
                  ),
                  child: Text(
                    "check out",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
