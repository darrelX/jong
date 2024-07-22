import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jong/shop/logic/cubit/product_cubit.dart';
import 'package:provider/provider.dart';

import 'service_locator.dart';
import 'shared/routing/app_router.dart';
import 'shared/theme/light_theme.dart';

class Application extends StatelessWidget {
  Application({super.key});

  final _appRouter = getIt.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp.router(
        title: 'Jong',
        
        debugShowCheckedModeBanner: false,
        theme: buildLightTheme(),
        darkTheme: buildLightTheme(),
        routerConfig: _appRouter.config(),
        themeMode: ThemeMode.light,
        builder: (context, child) => _unFocusWrapper(child),
      ),
    );
  }
}

Widget _unFocusWrapper(Widget? child) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: child,
  );
}
