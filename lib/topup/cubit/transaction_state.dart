part of 'transaction_cubit.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {
  const TransactionInitial();
  @override
  List<Object> get props => [];
}

final class TransactionPending extends TransactionState {
  final TransactionModel? transactionModel;
  const TransactionPending({this.transactionModel});
  @override
  List<Object> get props => [transactionModel!];
}

final class TransactionFailure extends TransactionState {
  final String message;
  const TransactionFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class TransactionSuccess extends TransactionState {
  @override
  List<Object> get props => [];
}
