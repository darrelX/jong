import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/presentation/widget/ticket_widget.dart';
import 'package:jong/shared/extensions/context_extensions.dart';
import 'package:jong/shared/utils/const.dart';
import 'package:jong/history/data/models/ticket_model.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> b = {
      "id": 0,
      "data": [
        {"id": "name1", "number": 4, 'status': true},
        {"id": "name2", "number": 4, 'status': false},
        {"id": "name3", "number": 4, 'status': true},
        {"id": "name4", "number": 4, 'status': false},
        {"id": "name5", "number": 4, 'status': false},
        {"id": "name6", "number": 4, 'status': true},
        {"id": "name7", "number": 4, 'status': false},
        {"id": "name8", "number": 4, 'status': false},
        {"id": "name9", "number": 4, 'status': true},
        {"id": "name10", "number": 4, 'status': true},
        {"id": "name11", "number": 4, 'status': false},
        {"id": "name12", "number": 4, 'status': true},
        {"id": "name113", "number": 4, 'status': true},
      ]
    };

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 20,
            color: Colors.red,
          ),
          ...TicketModel.ticket['data']
              .where((value) {
                return value['status'] == true;
              })
              .toList()
              .map((value) => TicketWidget(
                  title: value['uuid'],
                  totalAmount: value['total_amount'],
                  date: value['created_at']))
              .toList(),
          // ...b['data'].map((_) {
          //   print(_);

          //   return Text(_['id']);
          // }),
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
