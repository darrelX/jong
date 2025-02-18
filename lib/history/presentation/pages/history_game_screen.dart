import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/logic/history_cubit/game_history_cubit.dart';
import 'package:jong/history/presentation/widgets/game_history_widget.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';

@RoutePage()
class HistoryGameScreen extends StatefulWidget {
  const HistoryGameScreen({super.key, required this.title});
  final Widget title;

  @override
  State<HistoryGameScreen> createState() => _HistoryGameScreenState();
}

class _HistoryGameScreenState extends State<HistoryGameScreen> {
  final GameHistoryCubit _cubit = GameHistoryCubit();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit.fetch(); // Initial fetch of data
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_cubit.hasReachedMax) {
      _cubit.fetch(); // Fetch more data when reaching the bottom
    }
  }

  Future<void> _onRefresh() async {
    await _cubit.fetch(); // Reload data on pull-to-refresh
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
        toolbarHeight: 70.h,
      ),
      body: BlocBuilder<GameHistoryCubit, GameHistoryState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is GameHistoryStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GameHistoryStateSuccess) {
            final listGameHistory = state.listGameHistory;

            if (listGameHistory.isEmpty) {
              // Cas où la liste est vide
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Aucun historique de jeu disponible pour le moment.",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _onRefresh,
                      child: Text(
                        "Actualiser",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => _onRefresh(),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 30.h),
                      itemCount: _cubit.hasReachedMax
                          ? listGameHistory.length
                          : listGameHistory.length + 1,
                      separatorBuilder: (context, i) => Gap(26.h),
                      itemBuilder: (context, index) {
                        if (index < listGameHistory.length) {
                          final gameHistory = listGameHistory[index];
                          return GameHistoryWidget(
                            amount: gameHistory.amount,
                            cote: gameHistory.cote,
                            createdAt: gameHistory.createdAt,
                            gain: gameHistory.gain,
                          );
                        }
                        if (!_cubit.hasReachedMax) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is GameHistoryStateFailure) {
            return Center(
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
            );
          }

          // Cas par défaut en cas d'état non pris en charge
          return Center(
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
          );
        },
      ),
    );
  }
}
