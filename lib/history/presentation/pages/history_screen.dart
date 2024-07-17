import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/presentation/widget/bottom_sheet_wiget.dart';
import 'package:jong/history/presentation/widget/ticket_widget.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/theme/app_colors.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/history/data/models/ticket_model.dart';
import 'package:jong/shared/widget/app_button.dart';
import 'package:jong/shared/widget/app_input.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final sheet = GlobalKey();
  final DraggableScrollableController _controllerDraggable =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerDraggable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 20,
            color: Colors.red,
          ),
          // ...TicketModel.ticket['data']
          //     .where((value) {
          //       return value['status'] == true;
          //     })
          //     .map((value) => TicketWidget(
          //         title: value['uuid'],
          //         totalAmount: value['total_amount'],
          //         date: value['created_at']))
          //     .toList(),
          Container(
            color: Colors.blue,
            child: const Text("dsds"),
          ),
          ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    elevation: 0.6,
                    // constraints: const BoxConstraints(),
                    // isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return const BottomSheetWiget(
                        qunatity: 4,
                        totalAmount: 3,
                        ticketId: 'fef',
                      );
                    });
              },
              child: const Text(
                'kb',
                style: TextStyle(color: Colors.red),
              )),

          Container(
            height: 20,
            color: Colors.red,
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 25,
          //     itemBuilder: (BuildContext context, int index) {
          //       return ListTile(
          //         title: Text('Liste 2 - Élément $index'),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
