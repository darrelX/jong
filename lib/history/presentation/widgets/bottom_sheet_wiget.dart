import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/data/models/product_ticket_model.dart';
import 'package:jong/history/data/models/ticket_model.dart';
import 'package:jong/history/presentation/widgets/products_of_ticket.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';

class BottomSheetWiget extends StatelessWidget {
  const BottomSheetWiget(
      {super.key,
      required this.ticket,
      required this.products,
      required this.total});
  final TicketModel ticket;
  final int total;
  final List<ProductTicketModel> products;

  @override
  Widget build(BuildContext context) {
    // final ScrollController _scrollController = ScrollController();
    return SizedBox(
      height: 400.h,
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.1,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Container(
            height: 180.h,
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
                Gap(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                              const TextSpan(
                                text: 'Tiquet Numero : ',
                              ),
                              TextSpan(
                                  text: ' ${ticket.id!}',
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ])),
                        Gap(5.h),
                        Text(
                          "Nombre de bouteilles : $total",
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
                                children: [
                              TextSpan(
                                  text: '${ticket.totalAmount}',
                                  style: context.textTheme.titleLarge!
                                      .copyWith(color: Colors.white)),
                            ])),
                      ],
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: 110.w,
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
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductsOfTicket(
                          image: 'assets/images/1000.png',
                          product: products[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
