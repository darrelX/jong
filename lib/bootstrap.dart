import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shop/data/models/product_model.dart';
import 'package:jong/shop/logic/product_provider.dart';
import 'package:jong/shop/presentation/pages/shop_screen.dart';
import 'package:provider/provider.dart';

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

      runApp(ChangeNotifierProvider(
          create: (context) => ProductProvider(), child: await builder.call()));
    },
    (error, stack) {
      if (kDebugMode) {
        print(error);
      }
    },
  );
}
