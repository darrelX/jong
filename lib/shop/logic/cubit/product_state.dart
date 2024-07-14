part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductUpdated extends ProductState {
  final Map<String, dynamic> articles;
  final Map<String, int> products;
  final double? getTotalPrice;

  const ProductUpdated(
      {required this.articles,
      required this.products,
      this.getTotalPrice = 0.0});

  @override
  List<Object> get props => [articles, products, getTotalPrice!];
}
