// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AppInitRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppInitScreen(),
      );
    },
    ApplicationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ApplicationScreen(),
      );
    },
    ForgetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgetPasswordRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ForgetPasswordScreen(
          key: args.key,
          title1: args.title1,
          hasForgottenPassword: args.hasForgottenPassword,
          description: args.description,
          title2: args.title2,
        ),
      );
    },
    GameRoute.name: (routeData) {
      final args = routeData.argsAs<GameRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: GameScreen(
          key: args.key,
          bet: args.bet,
        ),
      );
    },
    HistoryGameRoute.name: (routeData) {
      final args = routeData.argsAs<HistoryGameRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HistoryGameScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    HistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    NewPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewPasswordScreen(),
      );
    },
    OTPInputRoute.name: (routeData) {
      final args = routeData.argsAs<OTPInputRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OTPInputScreen(
          key: args.key,
          number: args.number,
          hasForgottenPassword: args.hasForgottenPassword,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterScreen(),
      );
    },
    ShopRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShopScreen(),
      );
    },
    TopUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TopUpScreen(),
      );
    },
  };
}

/// generated route for
/// [AppInitScreen]
class AppInitRoute extends PageRouteInfo<void> {
  const AppInitRoute({List<PageRouteInfo>? children})
      : super(
          AppInitRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppInitRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ApplicationScreen]
class ApplicationRoute extends PageRouteInfo<void> {
  const ApplicationRoute({List<PageRouteInfo>? children})
      : super(
          ApplicationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ApplicationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ForgetPasswordScreen]
class ForgetPasswordRoute extends PageRouteInfo<ForgetPasswordRouteArgs> {
  ForgetPasswordRoute({
    Key? key,
    required String title1,
    bool hasForgottenPassword = true,
    required String description,
    required String title2,
    List<PageRouteInfo>? children,
  }) : super(
          ForgetPasswordRoute.name,
          args: ForgetPasswordRouteArgs(
            key: key,
            title1: title1,
            hasForgottenPassword: hasForgottenPassword,
            description: description,
            title2: title2,
          ),
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordRoute';

  static const PageInfo<ForgetPasswordRouteArgs> page =
      PageInfo<ForgetPasswordRouteArgs>(name);
}

class ForgetPasswordRouteArgs {
  const ForgetPasswordRouteArgs({
    this.key,
    required this.title1,
    this.hasForgottenPassword = true,
    required this.description,
    required this.title2,
  });

  final Key? key;

  final String title1;

  final bool hasForgottenPassword;

  final String description;

  final String title2;

  @override
  String toString() {
    return 'ForgetPasswordRouteArgs{key: $key, title1: $title1, hasForgottenPassword: $hasForgottenPassword, description: $description, title2: $title2}';
  }
}

/// generated route for
/// [GameScreen]
class GameRoute extends PageRouteInfo<GameRouteArgs> {
  GameRoute({
    Key? key,
    required double bet,
    List<PageRouteInfo>? children,
  }) : super(
          GameRoute.name,
          args: GameRouteArgs(
            key: key,
            bet: bet,
          ),
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const PageInfo<GameRouteArgs> page = PageInfo<GameRouteArgs>(name);
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    required this.bet,
  });

  final Key? key;

  final double bet;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, bet: $bet}';
  }
}

/// generated route for
/// [HistoryGameScreen]
class HistoryGameRoute extends PageRouteInfo<HistoryGameRouteArgs> {
  HistoryGameRoute({
    Key? key,
    required Widget title,
    List<PageRouteInfo>? children,
  }) : super(
          HistoryGameRoute.name,
          args: HistoryGameRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'HistoryGameRoute';

  static const PageInfo<HistoryGameRouteArgs> page =
      PageInfo<HistoryGameRouteArgs>(name);
}

class HistoryGameRouteArgs {
  const HistoryGameRouteArgs({
    this.key,
    required this.title,
  });

  final Key? key;

  final Widget title;

  @override
  String toString() {
    return 'HistoryGameRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [HistoryScreen]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewPasswordScreen]
class NewPasswordRoute extends PageRouteInfo<void> {
  const NewPasswordRoute({List<PageRouteInfo>? children})
      : super(
          NewPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OTPInputScreen]
class OTPInputRoute extends PageRouteInfo<OTPInputRouteArgs> {
  OTPInputRoute({
    Key? key,
    required String? number,
    bool hasForgottenPassword = true,
    List<PageRouteInfo>? children,
  }) : super(
          OTPInputRoute.name,
          args: OTPInputRouteArgs(
            key: key,
            number: number,
            hasForgottenPassword: hasForgottenPassword,
          ),
          initialChildren: children,
        );

  static const String name = 'OTPInputRoute';

  static const PageInfo<OTPInputRouteArgs> page =
      PageInfo<OTPInputRouteArgs>(name);
}

class OTPInputRouteArgs {
  const OTPInputRouteArgs({
    this.key,
    required this.number,
    this.hasForgottenPassword = true,
  });

  final Key? key;

  final String? number;

  final bool hasForgottenPassword;

  @override
  String toString() {
    return 'OTPInputRouteArgs{key: $key, number: $number, hasForgottenPassword: $hasForgottenPassword}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ShopScreen]
class ShopRoute extends PageRouteInfo<void> {
  const ShopRoute({List<PageRouteInfo>? children})
      : super(
          ShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TopUpScreen]
class TopUpRoute extends PageRouteInfo<void> {
  const TopUpRoute({List<PageRouteInfo>? children})
      : super(
          TopUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'TopUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
