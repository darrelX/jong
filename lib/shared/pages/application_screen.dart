import 'package:auto_route/auto_route.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/routing/app_router.dart';
import 'package:jong/shared/theme/app_colors.dart';

import '../widget/jong_app_bar.dart';

@RoutePage()
class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        switch (tabsRouter.activeIndex) {
          case 0:
            return AppBar(
              title: const JongAppBar(
                title: "Home",
              ),
            );
          case 1:
            return AppBar(
              title: const JongAppBar(
                title: "Jong shop",
              ),
            );
          case 2:
            return AppBar(
              title: const JongAppBar(
                title: "History",
              ),
            );
          case 3:
            return AppBar(
              title: const Text("Profile"),
              actions: [
                SvgPicture.asset(
                  'assets/icons/settings.svg',
                ),
                const Gap(10),
              ],
            );
          default:
            return AppBar();
        }
      },
      routes: const [
        HomeRoute(),
        ShopRoute(),
        HistoryRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return FlashyTabBar(
          selectedIndex: tabsRouter.activeIndex,
          showElevation: true,
          onItemSelected: tabsRouter.setActiveIndex,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          items: [
            FlashyTabBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
              ),
              title: SvgPicture.asset(
                'assets/icons/home.svg',
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.icon,
            ),
            FlashyTabBarItem(
              // icon: SvgPicture.asset('assets/icons/shop.svg'),
              // title: SvgPicture.asset(
              //   'assets/icons/shop.svg',
              //   colorFilter: const ColorFilter.mode(
              //     AppColors.primary,
              //     BlendMode.srcIn,
              //   ),
              // ),
              icon: Image.asset(
                'assets/icons/shop.png',
                height: 25,
                width: 25,
              ),
              title: Image.asset(
                'assets/icons/shop.png',
                height: 30,
                width: 30,
                color: AppColors.primary,
              ),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.icon,
            ),
            FlashyTabBarItem(
              icon: SvgPicture.asset(
                'assets/icons/history.svg',
              ),
              title: SvgPicture.asset(
                'assets/icons/history.svg',
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.icon,
            ),
            FlashyTabBarItem(
              icon: SvgPicture.asset(
                'assets/icons/profile.svg',
              ),
              title: SvgPicture.asset(
                'assets/icons/profile.svg',
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.icon,
            ),
          ],
        );
      },
    );
  }
}
