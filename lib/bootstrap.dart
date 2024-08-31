import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jong/auth/logic/cubit/auth_cubit.dart';
import 'package:jong/game/logic/bloc/crash_game_bloc.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shop/logic/cubit/product_cubit.dart';

_setupApplication() {
  /// Hide status bar for splash screen
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  LicenseRegistry.addLicense(
    () async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    },
  );
}

bootstrap({
  required FutureOr<Widget> Function() builder,
}) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      _setupApplication();
      setupLocator();

      runApp(MultiBlocProvider(providers: [
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<CrashGameBloc>(
          create: (context) => CrashGameBloc(),
        ),
      ], child: await builder.call()));
    },
    (error, stack) {
      if (kDebugMode) {
        print(error);
      }
    },
  );
}
