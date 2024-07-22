import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';

class ValidationWidget extends StatelessWidget {
  const ValidationWidget({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("En attente de validation",
            style: context.textTheme.titleLarge!
                .copyWith(color: AppColors.black, fontWeight: FontWeight.w900)),
        Gap(30.h),
        Text("Numero de ticket :",
            style: context.textTheme.bodyLarge!
                .copyWith(color: AppColors.grey, fontWeight: FontWeight.w900)),
        Gap(10.h),
        Text(id,
            style: context.textTheme.displaySmall!.copyWith(
                color: AppColors.primary, fontWeight: FontWeight.w900)),
        Gap(30.h),
        Container(
          height: 50,
          width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.primary,
          ),
          child: Center(
              child: Text(
            "Donner le numero au barman",
            style:
                context.textTheme.bodyLarge!.copyWith(color: AppColors.white),
            textAlign: TextAlign.center,
          )),
        )
      ],
    );
  }
}
