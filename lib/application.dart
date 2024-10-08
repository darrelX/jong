import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jong/auth/logic/otp_cubit/otp_bloc.dart';
import 'package:jong/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:jong/shared/connectivity/bloc/network_cubit.dart';

import 'service_locator.dart';
import 'shared/routing/app_router.dart';
import 'shared/theme/light_theme.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _appRouter = getIt.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<OtpBloc>(),
        ),
        BlocProvider(create: (context) => getIt.get<NetworkCubit>())
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp.router(
          title: 'Jong',
          localizationsDelegates: const [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          debugShowCheckedModeBanner: false,
          theme: buildLightTheme(),
          locale: const Locale('en'),
          darkTheme: buildLightTheme(),
          routerConfig: _appRouter.config(),
          themeMode: ThemeMode.dark,
          builder: (context, child) => _UnFocusWrapper(
            child: child,
          ),
        ),
      ),
    );
  }
}

class _UnFocusWrapper extends StatelessWidget {
  const _UnFocusWrapper({required this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
