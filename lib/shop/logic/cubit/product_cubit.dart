import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';
import 'package:jong/shop/data/models/product_model.dart';
import 'package:jong/shop/data/repositories/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository = getIt.get<ProductRepository>();
  final Map<String, int> counters = {};
  List<ProductModel> _listProductModel = [];
  final ApplicationCubit application = getIt.get<ApplicationCubit>();

  ProductCubit() : super(const ProductInitial());

  Future<void> fetchProducts() async {
    _listProductModel.clear();
    counters.clear();
    emit(const ProductLoadingState());
    try {
      _listProductModel =
          (await repository.fetchProductsList(application.state.user!.id!))
              .list;

      for (var article in _listProductModel) {
        counters[article.id!] = 0;
      }

      print(_listProductModel);
      emit(ProductUpdatedState(
          counters: counters,
          products: _listProductModel,
          getTotalPrice: getTotalPrice()));
    } catch (e) {
      emit(ProductFailure(message: e.toString()));
    }
  }

  void increment(String id, int quantity) {
    if (counters.containsKey(id) && counters[id]! < quantity) {
      counters[id] = counters[id]! + 1;
    }
    emit(ProductUpdatedState(
        counters: counters,
        products: _listProductModel,
        getTotalPrice: getTotalPrice()));
  }

  void decrement(String id) {
    if (counters.containsKey(id) && counters[id]! > 0) {
      counters[id] = counters[id]! - 1;
    }
    emit(ProductUpdatedState(
        counters: counters,
        products: _listProductModel,
        getTotalPrice: getTotalPrice()));
  }

  Future<void> getBasketItems() async {
    final List basketItems = _listProductModel
        .where((article) => counters[article.id]! > 0)
        .map((article) => {
              'id': article.id,
              'quantity': counters[article.id],
            })
        .toList();
    print("Darrel $basketItems");

    final Map<String, dynamic> result = {
      'user_id': application.state.user!.id!,
      'products': basketItems,
    };
    try {
      if (result.isEmpty) return;
      await repository.createTicket(result, application.state.user!.id!);
    } catch (e) {
      rethrow;
    }
  }

  double getTotalPrice() {
    double totalPrice = 0.0;

    for (var article in _listProductModel) {
      String id = article.id!;
      if (counters.containsKey(id) && counters[id]! > 0) {
        totalPrice += article.price! * counters[id]!;
      }
    }
    return double.parse(totalPrice.toStringAsFixed(2));
  }
}
