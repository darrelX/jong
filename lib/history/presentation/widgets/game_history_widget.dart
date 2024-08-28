import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';

class GameHistoryWidget extends StatelessWidget {
  const GameHistoryWidget(
      {super.key,
      required this.amount,
      required this.cote,
      required this.createdAt,
      required this.gain});
  final double? amount;
  final double? cote;
  final double? gain;
  final DateTime? createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A191C32),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x1A191C32),
            offset: Offset(-7, 10),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: SizedBox(
              width: double.infinity,
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icons/coins.png',
                    // fit: BoxFit.none,
                    height: 30,
                    // width: 40,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    amount!.toStringAsFixed(2),
                    textAlign: TextAlign.left,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'quote de ${cote!.toStringAsFixed(2)}',
                    textAlign: TextAlign.left,
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: AppColors.primary),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(createdAt!).toString(),
                    textAlign: TextAlign.left,
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: AppColors.green),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${gain!.toStringAsFixed(1)}nkap',
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w800),
                  ),
                  Text(
                    gain! > 0 ? 'gagné' : 'perdu',
                    style: context.textTheme.bodyLarge!
                        .copyWith(color: AppColors.green),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
