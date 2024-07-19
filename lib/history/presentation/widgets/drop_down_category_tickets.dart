import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/data/models/ticket_model.dart';
import 'package:jong/history/logic/cubit/ticket_cubit.dart';
import 'package:jong/history/presentation/widgets/ticket_widget.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';

class DropDownCategoryTickets extends StatelessWidget {
  const DropDownCategoryTickets(
      {super.key,
      required this.isDropOpen,
      required this.title,
      required this.onPressed,
      required this.status,
      required this.totalTickets,
      required this.tickets});
  final int totalTickets;
  final List<TicketModel> tickets;
  final bool status;
  final bool isDropOpen;
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isDropOpen ? null : 50.h,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      width: 360.w,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.05),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A191C32),
            offset: Offset(20, 0),
            blurRadius: 30,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment:
            isDropOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          if (isDropOpen) Gap(10.h),
          InkWell(
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Gap(25.h),
                Container(
                  constraints:
                      BoxConstraints(minWidth: 130.w, maxHeight: 200.w),
                  child: Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Gap(50.h),
                Icon(
                  !isDropOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.black,
                  size: 40.h,
                ),
                Gap(10.h),
                Text(
                  "$totalTickets",
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(30.h),
              ],
            ),
          ),
          if (isDropOpen) Gap(10.h),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 15.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A191C32),
                  // offset: Offset(0, 10),
                  blurRadius: 30,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Visibility(
              visible: isDropOpen,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...tickets.map((item) => TicketWidget(
                    total: tickets.length,
                      width: 410.h,
                     
                      ticket: item,
               )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
