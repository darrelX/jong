import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';
import 'package:jong/shop/data/models/product_model.dart';
import 'package:jong/shop/data/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoadingState { initial, loading, success, error }

class ProductProvider extends ChangeNotifier {
  final ProductRepository repository;
  Map<String, int> counters = {};
  List<ProductModel> listProductModel = [];
  LoadingState state = LoadingState.initial;
  Timer? timer;
  final ApplicationCubit application = getIt.get<ApplicationCubit>();

  // Initialise le compteur de tous les articles à 0
  ProductProvider()
      : repository = ProductRepository(
          dio: getIt.get<Dio>(),
          prefs: getIt.get<Future<SharedPreferences>>(),
        );

  Future<void> fetchProducts() async {
    listProductModel.clear();
    counters.clear();
    if (state == LoadingState.loading) return;
    state = LoadingState.loading;
    notifyListeners();
    try {
      listProductModel =
          await repository.fetchProductsList(application.state.user!.id!);
      if (counters.isEmpty && listProductModel.isNotEmpty) {
        for (var article in listProductModel) {
          counters[article.id!] = 0;
        }

        state = LoadingState.success;
        notifyListeners();
      }
    } catch (e) {
      state = LoadingState.error;
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }

  void increment(String id, int quantity) {
    if (counters.containsKey(id) && counters[id]! < quantity) {
      counters[id] = counters[id]! + 1;
    }
    notifyListeners();
  }

  void decrement(String id) {
    if (counters.containsKey(id) && counters[id]! > 0) {
      counters[id] = counters[id]! - 1;
    }
    notifyListeners();
  }

  Future<void> getBasketItems() async {
    final List basketItems = listProductModel
        .where((article) =>
            counters.containsKey("${article.id}") &&
            counters["${article.id}"]! > 0)
        .map((article) => {
              'id': "${article.id}",
              'quantity': counters["${article.id}"],
            })
        .toList();

    final result = {
      'user_id': application.state.user!.id!,
      'products': basketItems,
    };
    await repository.createTicket(result, application.state.user!.id!);
  }

  double getTotalPrice() {
    double totalPrice = 0.0;

    for (var article in listProductModel) {
      String id = "${article.id}";
      if (counters.containsKey(id) && counters[id]! > 0) {
        totalPrice += article.price! * counters[id]!;
      }
    }
    return double.parse(totalPrice.toStringAsFixed(2));
  }
}
