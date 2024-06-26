import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/utils/const.dart';

import '../../../shared/routing/app_router.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ApplicationCubit, ApplicationState>(
        bloc: getIt.get<ApplicationCubit>(),
        builder: (context, state) {
          return ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: padding24,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius20),
                    bottomRight: Radius.circular(radius20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/users.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Gap(20),
                    Text(
                      "${state.user?.username}",
                      style: context.textTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${state.user?.email}",
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Gap(20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(radius20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: padding24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            double.parse(state.user!.balance).toStringAsFixed(1),
                            style: context.textTheme.headlineMedium?.copyWith(),
                          ),
                          const Gap(4),
                          Text(
                            "nkap",
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(30),
              ListTile(
                onTap: () {},
                leading: SvgPicture.asset(
                  'assets/icons/help.svg',
                ),
                title: Text(
                  'Customer Support',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xffA7A7AB),
                ),
              ),
              const Gap(4),
              ListTile(
                onTap: () {
                  context.router.push(const TopUpRoute());
                },
                leading: Image.asset(
                  'assets/icons/coins.png',
                  width: 30,
                  height: 30,
                ),
                title: Text(
                  'Pop up your acount',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xffA7A7AB),
                ),
              ),
              const Gap(4),
              ListTile(
                onTap: () {
                  context.tabsRouter.setActiveIndex(2);
                },
                leading: SvgPicture.asset(
                  'assets/icons/historyy.svg',
                ),
                title: Text(
                  'Game history',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xffA7A7AB),
                ),
              ),
              const Gap(4),
              ListTile(
                onTap: () {
                  getIt.get<ApplicationCubit>().logout();
                  context.router.pushAndPopUntil(
                    const LoginRoute(),
                    predicate: (route) => false,
                  );
                },
                leading: SvgPicture.asset(
                  'assets/icons/logout.svg',
                ),
                title: Text(
                  'Logout',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
