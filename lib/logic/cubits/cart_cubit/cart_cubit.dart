import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_demo/data/modal/product_modal.dart';
import 'package:manektech_demo/data/repository/database_connection/database.dart';
import 'package:manektech_demo/utils/toast.dart';

import '../../../data/modal/cart_modal.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoadingState()) {
    fetchCartFromDb();
  }

  List<CartModal> cartItems = [];
  int cartCount = 0;
  double cartTotal = 0.0;

  DatabaseConnection db = DatabaseConnection();

  void fetchCartFromDb() async {
    try {
      cartItems = await db.getAllCartItems();
      calculateCartTotal();
      emit(CartLoadedState(cartItems, cartCount, cartTotal));
    } catch (e) {
      print(e.toString());
      emit(CartErrorState(e.toString()));
    }
  }

  void addProductToCart(ProductModal product) async {
    print(product.title);

    try {
      CartModal? cartItem = cartItems.firstWhereOrNull((element) => element.product.id == product.id);
      if (cartItem == null) {
        final CartModal newCartItem = CartModal(0, product, 1);
        final cartId = await db.addItemToCart(newCartItem);
        if (cartId != null) {
          newCartItem.cartId == cartId;
          cartItems.add(newCartItem);
          calculateCartTotal();
          emit(CartLoadedState(cartItems, cartCount, cartTotal));
        }
      } else {
        int index = cartItems.indexOf(cartItem);
        cartItem.qty++;
        cartItems[index] = cartItem;
        print(cartItem.qty);
        final cartId = await db.updateItemInCart(cartItem);
        print(cartId ?? 'Id null');
        calculateCartTotal();
        emit(CartLoadedState(cartItems, cartCount, cartTotal));
      }
      Toast.createToast('${product.title} added to cart');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> removeProductFromCart(CartModal cartItem) async {
    bool result = false;
    try {
      int index = cartItems.indexOf(cartItem);

      if (cartItem.qty > 1) {
        cartItem.qty--;
        cartItems[index] = cartItem;
        print(cartItem.qty);
        final cartId = await db.updateItemInCart(cartItem);
        print(cartId ?? 'Id null');
        calculateCartTotal();
        emit(CartLoadedState(cartItems, cartCount, cartTotal));
      } else {
        int index = cartItems.indexOf(cartItem);
        cartItems.removeAt(index);
        print(cartItem.qty);
        final cartId = await db.deleteItemFromCart(cartItem);
        print(cartId ?? 'Id null');
        calculateCartTotal();
        emit(CartLoadedState(cartItems, cartCount, cartTotal));
        result = true;
      }

      Toast.createToast('${cartItem.product.title} removed from cart');
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  void calculateCartTotal() {
    cartCount = 0;
    cartTotal = 0.0;
    cartItems.forEach((element) {
      cartCount += element.qty;
      cartTotal += element.qty * element.product.price;
    });
  }
}
