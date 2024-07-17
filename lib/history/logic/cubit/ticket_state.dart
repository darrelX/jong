part of 'ticket_cubit.dart';

sealed class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketStateInitial extends TicketState {
  const TicketStateInitial();
}

class TicketStateTreated extends TicketState {
  final bool status;
  const TicketStateTreated({required this.status});

    @override
  List<Object> get props => [status];
}

class TicketStateNotTreated extends TicketState {
  final bool status;
  const TicketStateNotTreated({required this.status});

    @override
  List<Object> get props => [status];
}
