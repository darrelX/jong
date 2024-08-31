// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:jong/app_init_screen.dart' as _i1;
import 'package:jong/auth/presentation/pages/login_screen.dart' as _i7;
import 'package:jong/auth/presentation/pages/otp_input_screen.dart' as _i8;
import 'package:jong/auth/presentation/pages/profile_screen.dart' as _i9;
import 'package:jong/auth/presentation/pages/register_screen.dart' as _i10;
import 'package:jong/game/presentation/pages/game_screen.dart' as _i3;
import 'package:jong/history/presentation/pages/history_game_screen.dart'
    as _i4;
import 'package:jong/history/presentation/pages/history_screen.dart' as _i5;
import 'package:jong/shared/pages/application_screen.dart' as _i2;
import 'package:jong/shared/pages/home_screen.dart' as _i6;
import 'package:jong/shop/presentation/pages/shop_screen.dart' as _i11;
import 'package:jong/topup/presentation/topup_screen.dart' as _i12;

abstract class $OfflineStatusWidget extends _i13.RootStackRouter {
  $OfflineStatusWidget({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    AppInitRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AppInitScreen(),
      );
    },
    ApplicationRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ApplicationScreen(),
      );
    },
    GameRoute.name: (routeData) {
      final args = routeData.argsAs<GameRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.GameScreen(
          key: args.key,
          bet: args.bet,
        ),
      );
    },
    HistoryGameRoute.name: (routeData) {
      final args = routeData.argsAs<HistoryGameRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.HistoryGameScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    HistoryRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HistoryScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginScreen(),
      );
    },
    OTPInputRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.OTPInputScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ProfileScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.RegisterScreen(),
      );
    },
    ShopRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ShopScreen(),
      );
    },
    TopUpRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.TopUpScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AppInitScreen]
class AppInitRoute extends _i13.PageRouteInfo<void> {
  const AppInitRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AppInitRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppInitRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ApplicationScreen]
class ApplicationRoute extends _i13.PageRouteInfo<void> {
  const ApplicationRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ApplicationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ApplicationRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GameScreen]
class GameRoute extends _i13.PageRouteInfo<GameRouteArgs> {
  GameRoute({
    _i14.Key? key,
    required double bet,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          GameRoute.name,
          args: GameRouteArgs(
            key: key,
            bet: bet,
          ),
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static const _i13.PageInfo<GameRouteArgs> page =
      _i13.PageInfo<GameRouteArgs>(name);
}

class GameRouteArgs {
  const GameRouteArgs({
    this.key,
    required this.bet,
  });

  final _i14.Key? key;

  final double bet;

  @override
  String toString() {
    return 'GameRouteArgs{key: $key, bet: $bet}';
  }
}

/// generated route for
/// [_i4.HistoryGameScreen]
class HistoryGameRoute extends _i13.PageRouteInfo<HistoryGameRouteArgs> {
  HistoryGameRoute({
    _i14.Key? key,
    required _i14.Widget title,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          HistoryGameRoute.name,
          args: HistoryGameRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'HistoryGameRoute';

  static const _i13.PageInfo<HistoryGameRouteArgs> page =
      _i13.PageInfo<HistoryGameRouteArgs>(name);
}

class HistoryGameRouteArgs {
  const HistoryGameRouteArgs({
    this.key,
    required this.title,
  });

  final _i14.Key? key;

  final _i14.Widget title;

  @override
  String toString() {
    return 'HistoryGameRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [_i5.HistoryScreen]
class HistoryRoute extends _i13.PageRouteInfo<void> {
  const HistoryRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LoginScreen]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i8.OTPInputScreen]
class OTPInputRoute extends _i13.PageRouteInfo<void> {
  const OTPInputRoute({List<_i13.PageRouteInfo>? children})
      : super(
          OTPInputRoute.name,
          initialChildren: children,
        );

  static const String name = 'OTPInputRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ProfileScreen]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i10.RegisterScreen]
class RegisterRoute extends _i13.PageRouteInfo<void> {
  const RegisterRoute({List<_i13.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ShopScreen]
class ShopRoute extends _i13.PageRouteInfo<void> {
  const ShopRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.TopUpScreen]
class TopUpRoute extends _i13.PageRouteInfo<void> {
  const TopUpRoute({List<_i13.PageRouteInfo>? children})
      : super(
          TopUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'TopUpRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}
