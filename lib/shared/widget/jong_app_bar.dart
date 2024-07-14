import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/extensions/context_extensions.dart';

import '../application/cubit/application_cubit.dart';
import '../theme/app_colors.dart';

class JongAppBar extends StatelessWidget {
  const JongAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/wallet2.png',
              width: 30,
              height: 30,
            ),
            Row(
              children: [
                BlocBuilder<ApplicationCubit, ApplicationState>(
                  bloc: getIt.get<ApplicationCubit>(),
                  builder: (context, state) {
                    return Text(
                      double.parse(state.user!.balance.toString())
                          .toStringAsFixed(1),
                    );
                  },
                ),
                const Gap(1),
                Text(
                  "  nkap",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                  ),
                )
              ],
            )
          ],
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Image.asset(
        //       'assets/images/wallet2.png',
        //       width: 10,
        //       height: 10,
        //     ),
        //     Expanded(
        //       child: Row(
        //         children: [
        //           BlocBuilder<ApplicationCubit, ApplicationState>(
        //             bloc: getIt.get<ApplicationCubit>(),
        //             builder: (context, state) {
        //               return Text(
        //                 double.parse(state.user!.balance.toString())
        //                     .toStringAsFixed(1),
        //               );
        //             },
        //           ),
        //           const Gap(1),
        //           Text(
        //             "nkap",
        //             style: context.textTheme.bodyMedium?.copyWith(
        //               color: AppColors.white,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
