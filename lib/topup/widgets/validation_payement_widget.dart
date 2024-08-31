import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/widget/app_button.dart';

class ValidationPayementWidget extends StatelessWidget {
  const ValidationPayementWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Votre payement a ete effectue",
              style: context.textTheme.titleLarge!.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.w900)),
          Gap(40.h),
          Image.asset(
            'assets/images/success.png',
            width: 100.w,
            fit: BoxFit.cover,
          ),
          Gap(40.h),
          AppButton(
            bgColor: AppColors.primary,
            textColor: Colors.white,
            onPressed: () => context.router.maybePop(),
            child: Text(
              "Quitter",
              style:
                  context.textTheme.titleLarge!.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
