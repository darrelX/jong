import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/const.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.isInCart = false,
  });
  final String image;
  final String title;
  final String price;
  final bool isInCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A191C32),
            offset: Offset(0, 20),
            blurRadius: 30,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Image.asset(
            image,
          ),
          const Gap(8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "$price nkap",
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (isInCart) ...[
            Text(
              '4',
              style: context.textTheme.displaySmall?.copyWith(),
            ),
            const Gap(10),
          ] else
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          radius10,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(
                            radius10,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/remove.svg',
                            width: 10,
                            height: 10,
                          ),
                        ),
                      ),
                    ),
                    const Gap(8),
                    Text(
                      "1",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(8),
                    InkWell(
                      onTap: () {},
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          radius10,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(
                            radius10,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/add.svg',
                            width: 10,
                            height: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
        ],
      ),
    );
  }
}
