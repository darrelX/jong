part of 'tiquet_cubit.dart';

sealed class TiquetState extends Equatable {
  const TiquetState();

  @override
  List<Object> get props => [];
}

final class TiquetInitial extends TiquetState {}
