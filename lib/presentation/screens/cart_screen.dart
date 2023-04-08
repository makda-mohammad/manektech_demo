import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/modal/cart_modal.dart';
import '../../logic/cubits/cart_cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName = '/cart_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<CartCubit, CartState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is CartLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (state is CartLoadedState) {
                    if (state.cartItems.isNotEmpty) {
                      return OrientationBuilder(
                        builder: (ctx, orientation) {
                          if (orientation == Orientation.portrait) {
                            return ListView.builder(
                              itemBuilder: (ctx, i) => cartListTile(state.cartItems[i], context),
                              itemCount: state.cartItems.length,
                            );
                          } else {
                            return GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.6),
                                itemBuilder: (ctx, i) => cartListTile(state.cartItems[i], context),
                                itemCount: state.cartItems.length);
                          }
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Your cart is empty'),
                      );
                    }
                  }
                  return const Center(
                    child: Text('An error occurred'),
                  );
                },
              ),
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoadedState) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.075,
                    color: Colors.lightBlueAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Items: ${state.cartCount}',
                            style: const TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                          Text(
                            'Grand Total: ${state.cartTotal}',
                            style: const TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget cartListTile(CartModal cartItem, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: Key(cartItem.cartId.toString()),
        confirmDismiss: (dismissDirection) async {
          return await context.read<CartCubit>().removeProductFromCart(cartItem);
        },
        child: SizedBox(
          height: 170,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Image.network(cartItem.product.featuredImage),
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            cartItem.product.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [const Text('Price'), Text('₹${cartItem.product.price}')],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [const Text('Quantity'), Text(cartItem.qty.toString())],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
