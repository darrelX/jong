import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jong/history/data/models/ticket_model.dart';
import 'package:jong/history/data/repositories/ticket_repository.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';

part 'ticket_state.dart';

enum LoadingState { initial, loading, success, error }

class TicketCubit extends Cubit<TicketState> {
  final TicketRepository ticketRepository;
  final ApplicationCubit _application;
  final _treatedTickets = <TicketModel>[];
  final _notTreatedTickets = <TicketModel>[];

  TicketCubit()
      : ticketRepository = getIt.get<TicketRepository>(),
        _application = getIt.get<ApplicationCubit>(),
        super(const TicketStateInitial());

  toggleToTreated(int id) async {
    // final List<TicketModel> copiedTreatedTickets = List.from(treatedTickets);
    final List<TicketModel> copiedNotTreatedTickets =
        List.from(_notTreatedTickets);
    await fetchTicketsList();
    copiedNotTreatedTickets != _notTreatedTickets;

    emit(const TicketStateToggle());
  }

  Future<void> fetchTicketsList() async {
    _treatedTickets.clear();
    _notTreatedTickets.clear();
    emit(TicketStateLoading(
        treatedTickets: _treatedTickets,
        notTreatedTickets: _notTreatedTickets));
    try {
      List<TicketModel> ticketsList = (await ticketRepository
          .fetchTicketsList(_application.state.user!.id!))!;

      for (var ticket in ticketsList) {
        if (ticket.status == true) {
          _treatedTickets.add(ticket);
        } else {
          _notTreatedTickets.add(ticket);
        }
      }

      emit(TicketStateSuccess(
          treatedTickets: _treatedTickets,
          notTreatedTickets: _notTreatedTickets));

      return;
    } catch (e) {
      emit(TicketFailure(message: e.toString()));
      return;
    }
  }

  Future<void> deleteTicket(int id) async {
    try {
      await ticketRepository.deleteTicket(id);
      emit(TicketStateSuccess(
          treatedTickets: _treatedTickets,
          notTreatedTickets: _notTreatedTickets));
    } catch (e) {
      emit(TicketFailure(message: e.toString()));

    }
  }
}
