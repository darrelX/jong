import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/presentation/widget/ticket_widget.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/utils/const.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(
            padding16,
          ),
          child: Column(
            children: [
              Text(
                "Tiquet non traiter",
                style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                ),
              ),
              Gap(30.h),
              const TicketWidget(
                title: 'Tiquet 583xde7',
                price: '2500',
                date: '26 .11 .2021  -  5:15 AM',
              ),
              const Gap(20),
              const TicketWidget(
                title: 'Tiquet 583xde7',
                price: '2500',
                date: '26 .11 .2021  -  5:15 AM',
              ),
              const Gap(20),
              const TicketWidget(
                title: 'Tiquet 583xde7',
                price: '2500',
                date: '26 .11 .2021  -  5:15 AM',
              ),
              const Gap(20),
              const TicketWidget(
                title: 'Tiquet 583xde7',
                price: '2500',
                date: '26 .11 .2021  -  5:15 AM',
              ),
              Gap(30.h),
              Text(
                "Tiquet traiter",
                style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                ),
              ),
              Gap(30.h),
              const TicketWidget(
                title: 'Tiquet 583xde7',
                price: '2500',
                date: '26 .11 .2021  -  5:15 AM',
                isTreated: true,
              ),
              const Gap(20),
              const TicketWidget(
                title: 'Tiquet 583xde7',
                price: '2500',
                date: '26 .11 .2021  -  5:15 AM',
                isTreated: true,
              ),
              const Gap(20),
              const TicketWidget(
                title: 'Tiquet 583xde7',
                price: '2500',
                date: '26 .11 .2021  -  5:15 AM',
                isTreated: true,
              ),
              const Gap(20),
              const TicketWidget(
                title: 'Tiquet 583xde7',
                price: '2500',
                date: '26 .11 .2021  -  5:15 AM',
                isTreated: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
