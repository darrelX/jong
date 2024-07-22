part of 'ticket_cubit.dart';

sealed class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

final class TicketStateInitial extends TicketState {
  const TicketStateInitial();
}

final class TicketStateLoading extends TicketState {
  final List<TicketModel> treatedTickets;
  final List<TicketModel> notTreatedTickets;
  const TicketStateLoading(
      {required this.treatedTickets, required this.notTreatedTickets});
}

final class TicketStateSuccess extends TicketState {
  final List<TicketModel> treatedTickets;
  final List<TicketModel> notTreatedTickets;
  const TicketStateSuccess(
      {required this.treatedTickets, required this.notTreatedTickets});
}

final class TicketStateToggle extends TicketState {
  const TicketStateToggle();

  @override
  List<Object> get props => [];
}

final class TicketStateNotTreated extends TicketState {
  final bool status;
  final List<TicketModel> tickets;
  final int total;
  const TicketStateNotTreated(
      {required this.tickets, required this.total, required this.status});

  @override
  List<Object> get props => [status, tickets, total];
}

final class TicketFailure extends TicketState {
  final String message;
  const TicketFailure({required this.message});
  @override
  List<Object> get props => [message];
}
