import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ticket_state.dart';

class TiquetCubit extends Cubit<TicketState> {
  TiquetCubit() : super(const TicketStateInitial());

  toggleToTreated(bool status) {
    if (status = true) {
      emit(TicketStateTreated(status: status));
    } else {
      emit(TicketStateNotTreated(status: status));
    }
  }
}
