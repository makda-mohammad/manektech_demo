part of 'products_cubit.dart';


abstract class ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final List<ProductModal> products;

  ProductsLoadedState(this.products);
}

class ProductsErrorState extends ProductsState {
  final String errorMsg;

  ProductsErrorState(this.errorMsg);
}
