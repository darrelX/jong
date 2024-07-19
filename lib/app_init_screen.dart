import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jong/auth/logic/cubit/auth_cubit.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';

import 'shared/routing/app_router.dart';
import 'shared/theme/app_colors.dart';

@RoutePage()
class AppInitScreen extends StatefulWidget {
  const AppInitScreen({super.key});

  @override
  State<AppInitScreen> createState() => _AppInitScreenState();
}

class _AppInitScreenState extends State<AppInitScreen> {
  final AuthCubit _cubit = AuthCubit();

  @override
  void initState() {
    super.initState();
    _cubit.checkAuthState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.primary,
          systemNavigationBarColor: AppColors.primary,
          systemNavigationBarDividerColor: AppColors.primary,
        ),
        child: BlocListener<AuthCubit, AuthState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state is CheckAuthStateFailure) {
              context.router.pushAndPopUntil(
                const LoginRoute(),
                predicate: (route) => false,
              );
            }

            if (state is CheckAuthStateSuccess) {
              getIt.get<ApplicationCubit>().setUser(state.user);
              context.router.pushAndPopUntil(
                const ApplicationRoute(),
                predicate: (route) => false,
              );
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.primary,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ZoomIn(
                    duration: const Duration(milliseconds: 3200),
                    from: 1.5,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/jong.svg',
                          width: 180,
                          height: 127,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
