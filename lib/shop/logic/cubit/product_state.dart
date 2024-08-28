part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {
  const ProductInitial();
  @override
  List<Object> get props => [];
}

final class ProductLoadingState extends ProductState {
  const ProductLoadingState();

  @override
  List<Object> get props => [];
}

final class ProductUpdatedState extends ProductState {
  final Map<String, int> counters;
  final List<ProductModel> products;
  final double? getTotalPrice;

  const ProductUpdatedState(
      {required this.counters,
      required this.products,
      this.getTotalPrice = 0.0});

  @override
  List<Object> get props => [counters, products, getTotalPrice!];
}

final class ProductFailure extends ProductState {
  final String message;

  const ProductFailure({required this.message});

  @override
  List<Object> get props => [message];
}
