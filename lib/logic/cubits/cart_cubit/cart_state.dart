part of 'cart_cubit.dart';

abstract class CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartModal> cartItems;
  int cartCount;
  double cartTotal;

  CartLoadedState(this.cartItems, this.cartCount, this.cartTotal);
}

class CartErrorState extends CartState {
  final String error;

  CartErrorState(this.error);
}
