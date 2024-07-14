import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tiquet_state.dart';

class TiquetCubit extends Cubit<TiquetState> {
  TiquetCubit() : super(TiquetInitial());
}
