import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/logic/cubit/ticket_cubit.dart';
import 'package:jong/history/presentation/widgets/bottom_sheet_wiget.dart';
import 'package:jong/history/presentation/widgets/drop_down_category_tickets.dart';
import 'package:jong/history/presentation/widgets/ticket_widget.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TicketCubit cubit = TicketCubit();
  bool _isFirstDropdownOpen = false;
  bool _isSecondDropdownOpen = false;

  Future<void> _refresh() async {
    await cubit.fetchTicketsList();
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
    cubit.fetchTicketsList();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(
      bloc: cubit,
      builder: (context, state) {
        print("state $state");

        if (state is TicketStateLoading) {
          return const CircularProgressIndicator(
            value: 30,
          );
        }
        if (state is TicketStateSuccess) {
          return Scaffold(
            body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor,
                // borderRadius: BorderRadius.circular(15),
                // border: Border.all(width: 0.05),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(20.h),
                    DropDownCategoryTickets(
                      onPressed: _toggleFirstDropdown,
                      title: "Tickets non traités",
                      isDropOpen: _isFirstDropdownOpen,
                      totalTickets: state.treatedTickets.length,
                      tickets: state.treatedTickets,
                      status: false,
                    ),
                    Gap(30.h),
                    DropDownCategoryTickets(
                      onPressed: _toggleSecondDropdown,
                      title: "Tickets traités",
                      status: true,
                      isDropOpen: _isSecondDropdownOpen,
                      totalTickets: state.notTreatedTickets.length,
                      tickets: state.notTreatedTickets,
                    ),
                    Gap(49.h),
                    // DropDownCategoryTickets(
                    //   title: "Tickets traités",
                    //   isDropOpen: _isSecondDropdownOpen,
                    //   total: 10,
                    //   onPressed: _toggleSecondDropdown,
                    // ),

                    // Container(),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       showModalBottomSheet(
                    //           context: context,
                    //           elevation: 0.6,
                    //           // constraints: const BoxConstraints(),
                    //           // isScrollControlled: true,
                    //           backgroundColor: Colors.transparent,
                    //           builder: (BuildContext context) {
                    //             return BottomSheetWiget(
                    //                 qunatity: 4,
                    //                 totalAmount: 3,
                    //                 ticketId: 'fef',
                    //                 products: state);
                    //           });
                    //     },
                    //     child: const Text(
                    //       'kb',
                    //       style: TextStyle(color: Colors.red),
                    //     )),
                  ],
                ),
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
