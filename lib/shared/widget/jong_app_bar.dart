import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/extensions/context_extensions.dart';

import '../application/cubit/application_cubit.dart';
import '../theme/app_colors.dart';

class JongAppBar extends StatefulWidget {
  const JongAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<JongAppBar> createState() => _JongAppBarState();
}

class _JongAppBarState extends State<JongAppBar> {
  @override
  void initState() {
    super.initState();
    getIt.get<ApplicationCubit>().setUser();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(widget.title),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/wallet2.png',
              width: 30.w,
              height: 30.h,
            ),
            Row(
              children: [
                BlocBuilder<ApplicationCubit, ApplicationState>(
                  bloc: getIt.get<ApplicationCubit>(),
                  builder: (context, state) {
                    return Text(
                      double.parse(state.user!.balance!.toString())
                          .toStringAsFixed(2),
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
      ],
    );
  }
}
