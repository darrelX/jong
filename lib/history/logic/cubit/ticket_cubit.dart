import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jong/history/data/models/ticket_model.dart';
import 'package:jong/history/data/repositories/ticket_repository.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final TicketRepository ticketRepository;
  final ApplicationCubit application;
  final treatedTickets = <TicketModel>[];
  final notTreatedTickets = <TicketModel>[];

  TicketCubit()
      : ticketRepository = getIt.get<TicketRepository>(),
        application = getIt.get<ApplicationCubit>(),
        super(const TicketStateInitial());

  // toggleToTreated(bool status) {
  //   if (status = true) {
  //     emit(TicketStateTreated(status: status));
  //   } else {
  //     emit(TicketStateNotTreated(status: status));
  //   }
  // }

  Future<void> fetchTicketsList() async {
    treatedTickets.clear();
    notTreatedTickets.clear();
    try {
      emit(TicketStateLoading(
          treatedTickets: treatedTickets,
          notTreatedTickets: notTreatedTickets));

      List<TicketModel> ticketsList = (await ticketRepository
          .fetchTicketsList(application.state.user!.id!))!;

      for (var ticket in ticketsList) {
        if (ticket.status == true) {
          treatedTickets.add(ticket);
        } else {
          notTreatedTickets.add(ticket);
        }
      }
      emit(TicketStateSuccess(
          treatedTickets: treatedTickets,
          notTreatedTickets: notTreatedTickets));

      return;
    } catch (e) {
      emit(TicketFailure(message: e.toString()));
      return;
    }
  }
}
