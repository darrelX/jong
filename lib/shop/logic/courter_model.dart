import 'package:flutter/cupertino.dart';

class CounterModel extends ChangeNotifier {
  final Map<String, dynamic> _articles = {
    "id": "",
    "items": [
      {
        "title": "dada",
        "price": 100,
        "quantity": 8,
        "id": "0",
        "isShop": false
      },
      {
        "title": "dada1",
        "price": 200,
        "quantity": 2,
        "id": "1",
        "isShop": false
      },
      {
        "title": "dada2",
        "price": 300,
        "quantity": 1,
        "id": "2",
        "isShop": false
      },
      {
        "title": "dada3",
        "price": 400,
        "quantity": 9,
        "id": "3",
        "isShop": false
      },
      {
        "title": "dada4",
        "price": 550,
        "quantity": 3,
        "id": "4",
        "isShop": false
      },
      {
        "title": "dada5",
        "price": 600,
        "quantity": 1,
        "id": "5",
        "isShop": false
      },
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

  Map<String, int> _counters = {};

  Map<String, dynamic> get articles => _articles;
  Map<String, int> get counters => _counters;

  // Initialise le compteur de tous les articles à 0
  CounterModel() {
    for (var article in _articles['items']) {
      _counters[article['id']] = 0;
    }
  }

  void increment(String id, int quantity) {
    if (_counters.containsKey(id) && _counters[id]! < quantity) {
      _counters[id] = _counters[id]! + 1;
    }
    notifyListeners();
  }

  void decrement(String id) {
    if (_counters.containsKey(id) && _counters[id]! > 0) {
      _counters[id] = _counters[id]! - 1;
    }
    notifyListeners();
  }

  Map<String, dynamic> getBasketItems(String token) {
    final List basketItems = _articles['items']
        .where((article) =>
            _counters.containsKey(article['id']) &&
            _counters[article['id']]! > 0)
        .map((article) => {
              'id': article['id'],
              'quantity': _counters[article['id']],
            })
        .toList();

    return {
      'user_id': token,
      'products': basketItems,
    };
  }

  double getTotalPrice() {
    double totalPrice = 0.0;

    for (var article in _articles['items']) {
      String id = article['id'];
      if (_counters.containsKey(id) && _counters[id]! > 0) {
        totalPrice += article['price'] * _counters[id]!;
      }
    }
    return totalPrice;
  }
}
