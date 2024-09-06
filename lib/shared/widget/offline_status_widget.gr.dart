// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:jong/app_init_screen.dart' as _i1;
import 'package:jong/auth/presentation/pages/forget_password_screen.dart'
    as _i3;
import 'package:jong/auth/presentation/pages/login_screen.dart' as _i8;
import 'package:jong/auth/presentation/pages/new_password_screen.dart' as _i9;
import 'package:jong/auth/presentation/pages/otp_input_screen.dart' as _i10;
import 'package:jong/auth/presentation/pages/profile_screen.dart' as _i11;
import 'package:jong/auth/presentation/pages/register_screen.dart' as _i12;
import 'package:jong/game/presentation/pages/game_screen.dart' as _i4;
import 'package:jong/history/presentation/pages/history_game_screen.dart'
    as _i5;
import 'package:jong/history/presentation/pages/history_screen.dart' as _i6;
import 'package:jong/shared/pages/application_screen.dart' as _i2;
import 'package:jong/shared/pages/home_screen.dart' as _i7;
import 'package:jong/shop/presentation/pages/shop_screen.dart' as _i13;
import 'package:jong/topup/presentation/topup_screen.dart' as _i14;

abstract class $OfflineStatusWidget extends _i15.RootStackRouter {
  $OfflineStatusWidget({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    AppInitRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AppInitScreen(),
      );
    },
    ApplicationRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ApplicationScreen(),
      );
    },
    ForgetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgetPasswordRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ForgetPasswordScreen(
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
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.GameScreen(
          key: args.key,
          bet: args.bet,
        ),
      );
    },
    HistoryGameRoute.name: (routeData) {
      final args = routeData.argsAs<HistoryGameRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.HistoryGameScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    HistoryRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HistoryScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LoginScreen(),
      );
    },
    NewPasswordRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.NewPasswordScreen(),
      );
    },
    OTPInputRoute.name: (routeData) {
      final args = routeData.argsAs<OTPInputRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.OTPInputScreen(
          key: args.key,
          number: args.number,
          hasForgottenPassword: args.hasForgottenPassword,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ProfileScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.RegisterScreen(),
      );
    },
    ShopRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.ShopScreen(),
      );
    },
    TopUpRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.TopUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AppInitScreen]
class AppInitRoute extends _i15.PageRouteInfo<void> {
  const AppInitRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AppInitRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppInitRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ApplicationScreen]
class ApplicationRoute extends _i15.PageRouteInfo<void> {
  const ApplicationRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ApplicationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ApplicationRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ForgetPasswordScreen]
class ForgetPasswordRoute extends _i15.PageRouteInfo<ForgetPasswordRouteArgs> {
  ForgetPasswordRoute({
    _i16.Key? key,
    required String title1,
    bool hasForgottenPassword = true,
    required String description,
    required String title2,
    List<_i15.PageRouteInfo>? children,
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

  static const _i15.PageInfo<ForgetPasswordRouteArgs> page =
      _i15.PageInfo<ForgetPasswordRouteArgs>(name);
}

class ForgetPasswordRouteArgs {
  const ForgetPasswordRouteArgs({
    this.key,
    required this.title1,
    this.hasForgottenPassword = true,
    required this.description,
    required this.title2,
  });

  final _i16.Key? key;

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
/// [_i4.GameScreen]
class GameRoute extends _i15.PageRouteInfo<GameRouteArgs> {
  GameRoute({
    _i16.Key? key,
    required double bet,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          GameRoute.name,
          args: GameRouteArgs(
            key: key,
            bet: bet,
          ),
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const _i15.PageInfo<GameRouteArgs> page =
      _i15.PageInfo<GameRouteArgs>(name);
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    required this.bet,
  });

  final _i16.Key? key;

  final double bet;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, bet: $bet}';
  }
}

/// generated route for
/// [_i5.HistoryGameScreen]
class HistoryGameRoute extends _i15.PageRouteInfo<HistoryGameRouteArgs> {
  HistoryGameRoute({
    _i16.Key? key,
    required _i16.Widget title,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          HistoryGameRoute.name,
          args: HistoryGameRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'HistoryGameRoute';

  static const _i15.PageInfo<HistoryGameRouteArgs> page =
      _i15.PageInfo<HistoryGameRouteArgs>(name);
}

class HistoryGameRouteArgs {
  const HistoryGameRouteArgs({
    this.key,
    required this.title,
  });

  final _i16.Key? key;

  final _i16.Widget title;

  @override
  String toString() {
    return 'HistoryGameRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [_i6.HistoryScreen]
class HistoryRoute extends _i15.PageRouteInfo<void> {
  const HistoryRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LoginScreen]
class LoginRoute extends _i15.PageRouteInfo<void> {
  const LoginRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i9.NewPasswordScreen]
class NewPasswordRoute extends _i15.PageRouteInfo<void> {
  const NewPasswordRoute({List<_i15.PageRouteInfo>? children})
      : super(
          NewPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPasswordRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.OTPInputScreen]
class OTPInputRoute extends _i15.PageRouteInfo<OTPInputRouteArgs> {
  OTPInputRoute({
    _i16.Key? key,
    required String? number,
    bool hasForgottenPassword = true,
    List<_i15.PageRouteInfo>? children,
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

  static const _i15.PageInfo<OTPInputRouteArgs> page =
      _i15.PageInfo<OTPInputRouteArgs>(name);
}

class OTPInputRouteArgs {
  const OTPInputRouteArgs({
    this.key,
    required this.number,
    this.hasForgottenPassword = true,
  });

  final _i16.Key? key;

  final String? number;

  final bool hasForgottenPassword;

  @override
  String toString() {
    return 'OTPInputRouteArgs{key: $key, number: $number, hasForgottenPassword: $hasForgottenPassword}';
  }
}

/// generated route for
/// [_i11.ProfileScreen]
class ProfileRoute extends _i15.PageRouteInfo<void> {
  const ProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.RegisterScreen]
class RegisterRoute extends _i15.PageRouteInfo<void> {
  const RegisterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.ShopScreen]
class ShopRoute extends _i15.PageRouteInfo<void> {
  const ShopRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.TopUpScreen]
class TopUpRoute extends _i15.PageRouteInfo<void> {
  const TopUpRoute({List<_i15.PageRouteInfo>? children})
      : super(
          TopUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'TopUpRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
