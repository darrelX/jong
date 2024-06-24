import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jong/game/logic/bloc/crash_game_bloc.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/routing/app_router.dart';
import 'package:jong/shared/widget/app_button.dart';
import 'package:jong/shared/widget/jong_app_bar.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/const.dart';
import '../../../shared/widget/app_dialog.dart';

@RoutePage()
class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    required this.bet,
  });
  final double bet;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late CrashGameBloc crashGameBloc;

  @override
  void initState() {
    crashGameBloc = CrashGameBloc(bet: widget.bet);
    super.initState();
  }

  @override
  void dispose() {
    crashGameBloc.dispose();
    crashGameBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.router.maybePop();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              "assets/icons/arrow_back.svg",
            ),
          ),
        ),
        title: const JongAppBar(title: 'Home'),
      ),
      body: BlocConsumer<CrashGameBloc, CrashGameState>(
        bloc: crashGameBloc,
        listener: (context, state) {
          if (state is CrashGameLost || state is CrashGameWon) {
            AppDialog.showDialog(
              context: context,
              width: 300,
              height: 270,
              child: GameResultDialog(
                crashGameBloc: crashGameBloc,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CrashGameInitial) {
            return Column(
              children: [
                const Spacer(flex: 2),
                Text(
                  "The game starts in 👇",
                  textAlign: TextAlign.center,
                  style: context.textTheme.displayMedium?.copyWith(
                    fontSize: 26.sp,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${state.countDown}",
                      style: context.textTheme.displayLarge?.copyWith(
                        color: AppColors.white,
                        fontSize: 120,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        widget.bet.toStringAsFixed(2),
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "nkap",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
              ],
            );
          }

          if (state is CrashGamePlaying) {
            return Column(
              children: [
                const Spacer(flex: 2),
                Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      state.multiplier.toStringAsFixed(2),
                      style: context.textTheme.displayLarge?.copyWith(
                        color: AppColors.white,
                        fontSize: 70.sp,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "x",
                      style: context.textTheme.displayLarge?.copyWith(
                        color: AppColors.primary,
                        fontSize: 40.sp,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        (state.bet * state.multiplier).toStringAsFixed(2),
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "nkap",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: padding24,
                  ),
                  child: AppButton(
                    bgColor: AppColors.primary,
                    text: "Stop",
                    onPressed: () {
                      crashGameBloc.add(
                        CashOutCrashGameWinningsEvent(
                          multiplier: state.multiplier,
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(flex: 2),
              ],
            );
          }

          if (state is CrashGameDefault) {
            return Column(
              children: [
                const Spacer(flex: 2),
                ZoomIn(
                  child: Image.asset(
                    "assets/images/jong_bet.png",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: padding16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          widget.bet.toStringAsFixed(2),
                          style: context.textTheme.displayLarge?.copyWith(
                            fontSize: 40.sp,
                          ),
                        ),
                      ),
                      const Gap(4),
                      Text(
                        "nkap",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: padding24,
                  ),
                  child: AppButton(
                    bgColor: AppColors.primary,
                    text: "Start",
                    onPressed: () {
                      crashGameBloc.add(InitializeCrashGameEvent());
                    },
                  ),
                ),
                const Spacer(flex: 2),
              ],
            );
          }

          return Column(
            children: [
              const Spacer(flex: 2),
              ZoomIn(
                child: Image.asset(
                  "assets/images/jong_bet.png",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: padding16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        widget.bet.toStringAsFixed(2),
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "nkap",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
            ],
          );
        },
      ),
    );
  }
}

class GameResultDialog extends StatelessWidget {
  const GameResultDialog({
    super.key,
    required this.crashGameBloc,
  });
  final CrashGameBloc crashGameBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrashGameBloc, CrashGameState>(
      bloc: crashGameBloc,
      builder: (context, state) {
        if (state is CrashGameLost) {
          return Padding(
            padding: const EdgeInsets.all(padding16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Too bad you lost",
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      state.bet.toStringAsFixed(2),
                      style: context.textTheme.displayLarge?.copyWith(
                        color: AppColors.red,
                        fontSize: 35.sp,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "nkap",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        bgColor: AppColors.primary,
                        text: 'New part',
                        onPressed: () {
                          context.router.pushAndPopUntil(
                            const HomeRoute(),
                            predicate: (route) => false,
                          );
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: AppButton(
                        borderColor: AppColors.primary,
                        text: 'Back to home',
                        onPressed: () {
                          context.router.popUntilRoot();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        if (state is CrashGameWon) {
          return Padding(
            padding: const EdgeInsets.all(padding16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Congratulations you won",
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      state.winnings.toStringAsFixed(2),
                      style: context.textTheme.displayLarge?.copyWith(
                        color: AppColors.green,
                        fontSize: 35.sp,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "nkap",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        bgColor: AppColors.primary,
                        text: 'New part',
                        onPressed: () {
                          context.router.popUntilRoot();
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: AppButton(
                        borderColor: AppColors.primary,
                        text: 'Back to home',
                        onPressed: () {
                          context.router.popUntilRoot();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
