import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jong/history/presentation/widget/ticket_widget.dart';

class TicketDropdownList extends StatefulWidget {
  final bool treated;
  final String title;
  final Map<String, dynamic> tickets;
  const TicketDropdownList(
      {super.key,
      this.treated = false,
      required this.title,
      required this.tickets});

  @override
  State<TicketDropdownList> createState() => _TicketDropdownListState();
}

class _TicketDropdownListState extends State<TicketDropdownList> {
  String? _selectedValue;
  bool _isDropdownOpen1 = false;
  final List<String> _dropdownItems = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isDropdownOpen1 = !_isDropdownOpen1;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white),
                ),
                Icon(
                  _isDropdownOpen1
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const Gap(20),
        if (_isDropdownOpen1)
          Column(
            children: widget.tickets['data']
                .where((value) => value['status'] == true)
                .toList()
                .map((dynamic value) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                child: TicketWidget(
                  title: value['uuid'],
                  totalAmount: value['total_amount'],
                  date: value['created_at'],
                  status: value,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
