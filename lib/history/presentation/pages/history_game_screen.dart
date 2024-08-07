import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/logic/history_cubit/game_history_cubit.dart';
import 'package:jong/history/presentation/widgets/game_history_widget.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
// import 'package:jong/shared/theme/app_colors.dart';

@RoutePage()
class HistoryGameScreen extends StatefulWidget {
  const HistoryGameScreen({super.key, required this.title});
  final Widget title;

  @override
  State<HistoryGameScreen> createState() => _HistoryGameScreenState();
}

class _HistoryGameScreenState extends State<HistoryGameScreen> {
  final GameHistoryCubit _cubit = GameHistoryCubit();

  Future<void> _onRefresh() async {
    await _cubit.fetch();
  }

  @override
  void initState() {
    super.initState();
    _cubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameHistoryCubit, GameHistoryState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is GameHistoryStateFailure) {
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Échec du chargement. Veuillez réessayer."),
                Gap(20.h),
                ElevatedButton(
                  onPressed: _onRefresh,
                  child: Text(
                    "Réessayer",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: widget.title,
            toolbarHeight: 70.h,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            // color: Colors.red,
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: Column(
                children: [
                  Gap(30.h),
                  Center(
                    child: Text("historique des parties",
                        style: context.textTheme.headlineMedium),
                  ),
                  Gap(20.h),
                  if (state is GameHistoryStateSuccess)
                    Expanded(
                        child: ListView.separated(
                            separatorBuilder: (context, i) => Gap(26.h),
                            itemCount: state.listGameHistory.length,
                            itemBuilder: (context, int elt) {
                              return GameHistoryWidget(
                                  amount: state.listGameHistory[elt].amount,
                                  cote: state.listGameHistory[elt].cote,
                                  createdAt:
                                      state.listGameHistory[elt].createdAt,
                                  gain: state.listGameHistory[elt].gain);
                            }))
                  else if (state is GameHistoryStateLoading)
                    Container()
                  else if (state is GameHistoryStateFailure)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Échec du chargement. Veuillez réessayer."),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _onRefresh,
                            child: Text(
                              "Réessayer",
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
