import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/widget/app_dialog.dart';
import 'package:jong/shared/widget/app_snackbar.dart';
import 'package:jong/shop/logic/cubit/product_cubit.dart';
import 'package:jong/shop/presentation/widget/checkout_widget.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/const.dart';

class PreviewWidget extends StatelessWidget {
  const PreviewWidget(
      {super.key, this.padding = const EdgeInsets.all(padding16), this.widget});
  final EdgeInsetsGeometry? padding;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    // final instance = context.read<ProductProvider>();
    final ProductCubit cubit = getIt.get<ProductCubit>();
    final ApplicationCubit _application = getIt.get<ApplicationCubit>();

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
            "Montant total",
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(20.h),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${cubit.getTotalPrice()}',
                    style: context.textTheme.displaySmall?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  Gap(4.h),
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
                onTap: () async {
                  try {
                    if (cubit.getTotalPrice() == 0) {
                      AppSnackBar.showError(
                          message: "Veuillez selectionner vos boissons",
                          context: context);
                    } else if (cubit.getTotalPrice() >=
                        _application.state.user!.balance!) {
                      AppSnackBar.showError(
                          message: "Solde insuffisant", context: context);
                    } else {
                      await cubit.getBasketItems();
                      if (!context.mounted) return;
                      return AppDialog.showDialog(
                        context: context,
                        height: 300,
                        child: const Padding(
                          padding: EdgeInsets.all(padding16),
                          child: CheckoutWidget(),
                        ),
                      );
                    }
                  } catch (e) {
                    if (!context.mounted) return;
                    AppSnackBar.showError(
                        message: "Une erreur inconnue s'est produite",
                        context: context);
                  }
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
                    "Vérifier",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              )
            ],
          ),
          widget ?? const SizedBox()
        ],
      ),
    );
  }
}
