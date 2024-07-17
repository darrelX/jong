import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';

import '../../../shared/theme/app_colors.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    super.key,
    required this.title,
    required this.totalAmount,
    required this.date,
    this.status = false,
  });

  final String title;
  final double totalAmount;
  final String date;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        // border: Border.all(width: 0.04),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A191C32),
            offset: Offset(3, 0),
            blurRadius: 2,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x1A191C32),
            offset: Offset(-5, 10),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: EdgeInsets.all(10.h),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: status ? null : AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(
                  status
                      ? 'assets/images/ticket_confirmed.png'
                      : 'assets/images/ticket.png',
                  width: 28,
                  height: 26,
                ),
              ),
            ),
          ),
          Gap(19.h),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  date,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                totalAmount.toStringAsFixed(2),
                style: context.textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                ),
              ),
              const Gap(4),
              Text(
                "nkap",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}