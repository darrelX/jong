import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

Map<String, dynamic> _articles = {
  "id": "",
  "items": [
    {"title": "dada", "price": 100, "quantity": 8, "id": "0", "isShop": false},
    {"title": "dada1", "price": 200, "quantity": 2, "id": "1", "isShop": false},
    {"title": "dada2", "price": 300, "quantity": 1, "id": "2", "isShop": false},
    {"title": "dada3", "price": 400, "quantity": 9, "id": "3", "isShop": false},
    {"title": "dada4", "price": 550, "quantity": 3, "id": "4", "isShop": false},
    {"title": "dada5", "price": 600, "quantity": 1, "id": "5", "isShop": false},
    {
      "title": "dada6",
      "price": 1200,
      "quantity": 4,
      "id": "6",
      "isShop": false
    },
    {
      "title": "dada7",
      "price": 3200,
      "quantity": 3,
      "id": "7",
      "isShop": false
    },
  ],
};

Map<String, int> _products = {};

class ProductCubit extends Cubit<ProductState> {
  Map<String, dynamic> get articles => _articles;
  Map<String, int> get products => _products;

  ProductCubit() : super(const ProductInitial()) {
    if (_products.isEmpty) {
      for (var article in articles['items']) {
        products[article['id']] = 0;
      }
      emit(const ProductInitial());
    }
    emit(ProductUpdated(
        articles: _articles,
        products: _products,
        getTotalPrice: getTotalPrice()));
  }

  void increment(String id, int quantity) {
    if (_products.containsKey(id) && _products[id]! < quantity) {
      _products[id] = _products[id]! + 1;
    }
    emit(ProductUpdated(
        articles: _articles,
        products: _products,
        getTotalPrice: getTotalPrice()));
  }

  void decrement(String id) {
    if (_products.containsKey(id) && _products[id]! > 0) {
      _products[id] = _products[id]! - 1;
    }
    emit(ProductUpdated(
        articles: _articles,
        products: _products,
        getTotalPrice: getTotalPrice()));
  }

  List<Map<String, dynamic>> getBasketItems() {
    List<Map<String, dynamic>> basketItems = [];

    for (var article in _articles['items']) {
      String id = article['id'];
      if (_products.containsKey(id) && _products[id]! > 0) {
        var basketItem = Map<String, dynamic>.from(article);
        basketItem['quantity'] = _products[id];
        basketItems.add(basketItem);
      }
    }
    return basketItems;
  }

  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var article in _articles['items']) {
      String id = article['id'];
      if (_products.containsKey(id) && _products[id]! > 0) {
        totalPrice += article['price'] * _products[id]!;
      }
    }
    return totalPrice;
  }
}
