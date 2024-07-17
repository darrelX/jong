import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shop/logic/product_provider.dart';
import 'package:provider/provider.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/const.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
    required this.id,
    this.isShop = false,
  });
  final String image;
  final String id;
  final String title;
  final double price;
  final int quantity;
  final bool isShop;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final instance = context.read<ProductProvider>();
    print('babadi');
    print('babadi ${instance.counters}');
    print("babadi ${instance.counters[widget.id]!}");

    return Visibility(
      visible: widget.isShop
          ? (instance.counters[widget.id]! < 1 ? false : true)
          : true,
      child: Container(
        height: 90.h,
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
        padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 8.h),
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.h),
        child: Row(
          children: [
            Image.asset(
              widget.image,
            ),
            const Gap(8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${widget.price} nkap",
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IgnorePointer(
                      ignoring:
                          instance.counters[widget.id]! > 0 ? false : true,
                      child: Opacity(
                        opacity: instance.counters[widget.id]! > 0 ? 1 : 0.5,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              instance.decrement(widget.id);
                            });
                          },
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
                      ),
                    ),
                    const Gap(8),
                    Text(
                      '${instance.counters[widget.id]}',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(8),
                    IgnorePointer(
                      ignoring: instance.counters[widget.id]! < widget.quantity
                          ? false
                          : true,
                      child: Opacity(
                        opacity: instance.counters[widget.id]! < widget.quantity
                            ? 1
                            : 0.5,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              instance.increment(widget.id, widget.quantity);
                            });
                          },
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
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
