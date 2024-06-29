import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/const.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
  });
  final String image;
  final String title;
  final int price;
  final int quantity;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int _counter = 0;

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
                    ignoring: _counter > 0 ? false : true,
                    child: Opacity(
                      opacity: _counter > 0 ? 1 : 0.5,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (_counter > 0) {
                              _counter--;
                            }
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
                    '$_counter',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(8),
                  IgnorePointer(
                    ignoring: _counter < widget.quantity ? false : true,
                    child: Opacity(
                      opacity: _counter < widget.quantity ? 1 : 0.5,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (_counter < widget.quantity) {
                              _counter++;
                            }
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
    );
  }
}
