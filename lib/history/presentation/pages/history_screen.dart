import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/logic/cubit/ticket_cubit.dart';
import 'package:jong/history/presentation/widgets/category_selector_widget.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TicketCubit _cubit = TicketCubit();
  bool _isFirstDropdownOpen = false;
  bool _isSecondDropdownOpen = false;

  Future<void> _onRefresh() async {
    await _cubit.fetchTicketsList();
  }

  void _toggleFirstDropdown() {
    setState(() {
      _isFirstDropdownOpen = !_isFirstDropdownOpen;
    });
  }

  void _toggleSecondDropdown() {
    setState(() {
      _isSecondDropdownOpen = !_isSecondDropdownOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    _cubit.fetchTicketsList();
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketCubit, TicketState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is TicketStateToggle) {}
      },
      builder: (context, state) {
        if (state is TicketStateLoading) {
          return Center(
            child: Transform.scale(
              scale: 2, // Réduire de moitié la taille du widget
              child: const CircularProgressIndicator(),
            ),
          );
        }
        if (state is TicketStateSuccess) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  height: MediaQuery.of(context).size.height - 70.h,
                  // decoration: const BoxDecoration(
                  //   color: Colors.transparent,
                  //   // borderRadius: BorderRadius.circular(15),
                  //   // border: Border.all(width: 0.05),
                  // ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gap(20.h),
                        TicketCategoryDropdown(
                          onPressed: _toggleFirstDropdown,
                          title: "Tickets non traités",
                          isDropOpen: _isFirstDropdownOpen,
                          totalTickets: state.treatedTickets.length,
                          tickets: state.treatedTickets,
                          status: false,
                        ),
                        Gap(30.h),
                        TicketCategoryDropdown(
                          onPressed: _toggleSecondDropdown,
                          title: "Tickets traités",
                          status: true,
                          isDropOpen: _isSecondDropdownOpen,
                          totalTickets: state.notTreatedTickets.length,
                          tickets: state.notTreatedTickets,
                        ),
                        Gap(49.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        if (state is TicketFailure) {
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
    );
  }
}
