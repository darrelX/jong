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
  // final _application = getIt.get<ApplicationCubit>();

  dynamic deposit(String method, int amount, String phoneNumber) async {
    try {
      final TransactionModel transactionModel = await repository.deposit(
          method: method,
          amount: amount,
          userId: _application.state.user!.id!,
          phoneNumber: phoneNumber);
      // setUser();
      if (transactionModel.status == 0) {
        emit(TransactionPending(transactionModel: transactionModel));
      } else if (transactionModel.status == 2) {
        emit(const TransactionFailure(message: "Transaction echouee"));
      }
      // return status['status'];
    } catch (e) {
      print("test");

      emit(TransactionFailure(message: e.toString()));
    }
  }

  checkStatut(int id) async {
    try {
      final status = await repository.getStatus(id: id);
      if (status == 1) {
        emit(TransactionSuccess());
      } else if (status == 2) {
        emit(const TransactionFailure(message: "Transactioin echouee"));
      }
    } catch (e) {
      emit(TransactionFailure(message: e.toString()));
    }
  }
}
