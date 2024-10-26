import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';
import 'package:jong/topup/data/models/transaction_model.dart';
import 'package:jong/topup/data/repositories/transaction_repository.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(const TransactionInitial());
  final TransactionRepository repository = TransactionRepository();
  final _application = getIt.get<ApplicationCubit>();
  int _id = 0;
  // final _application = getIt.get<ApplicationCubit>();

  dynamic deposit(String method, int amount, String phoneNumber) async {
    emit(const TransactionInitial());
    try {
      final TransactionModel transactionModel = await repository.deposit(
          method: method,
          amount: amount,
          userId: _application.state.user!.id!,
          phoneNumber: phoneNumber);
      _id = transactionModel.id!;
      // setUser();
      if (transactionModel.status == 1) {
        emit(TransactionSuccess());
      } else if (transactionModel.status == 2) {
        emit(const TransactionFailure(message: "Transaction echouee"));
      } else if (transactionModel.status == 0) {
        emit(const TransactionPending());
      }
      // return status['status'];
    } catch (e) {
      emit(TransactionFailure(message: e.toString()));
      rethrow;
    }
  }

  checkStatut() async {
    emit(const TransactionInitial());

    try {
      final result = await repository.getStatus(id: _id);
      if (result == 1) {
        emit(TransactionSuccess());
      } else if (result == 2) {
        emit(const TransactionFailure(message: "Transaction echouee"));
      }
    } catch (e) {
      emit(TransactionFailure(message: e.toString()));
    }
  }
}
