import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/data/models/product_ticket_model.dart';
import 'package:jong/shared/extensions/context_extensions.dart';


class ProductsOfTicket extends StatelessWidget {
  const ProductsOfTicket(
      {super.key, required this.product, required this.image});

  final ProductTicketModel product;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap(10.w),
          Image.asset(
            image,
          ),
          Gap(20.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name!,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${product.price!.toStringAsFixed(2)} nkap",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Gap(50.w),
          Text(
            "${product.quantity}",
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
