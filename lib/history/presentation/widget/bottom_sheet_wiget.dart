import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/presentation/widget/products_of_ticket.dart';
import 'package:jong/history/presentation/widget/ticket_widget.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';

class BottomSheetWiget extends StatelessWidget {
  const BottomSheetWiget(
      {super.key,
      required this.qunatity,
      required this.totalAmount,
      required this.ticketId});
  final int qunatity;
  final int totalAmount;
  final String ticketId;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.2,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(30.h),
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
              Gap(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: context.textTheme.titleMedium?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              children: const [
                            TextSpan(
                              text: 'Tiquet Numero :',
                            ),
                            TextSpan(
                                text: ' 3203h2',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w800)),
                          ])),
                      Gap(5.h),
                      Text(
                        "Nombre de bouteilles : 8",
                        textAlign: TextAlign.start,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(5.h),
                      RichText(
                          text: TextSpan(
                              style: context.textTheme.titleMedium?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              children: const [
                            TextSpan(
                                text: '2850', style: TextStyle(fontSize: 30)),
                            TextSpan(text: '  Nkap'),
                          ])),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: 130.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          'Traiter',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Gap(10.h),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (context, index) {
                    return const ProductsOfTicket(
                        name: 'name',
                        price: 4,
                        image: 'assets/images/1000.png',
                        quantity: 7);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
