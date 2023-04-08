import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_demo/data/modal/product_modal.dart';
import 'package:manektech_demo/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:manektech_demo/logic/cubits/products_cubit/products_cubit.dart';
import 'package:manektech_demo/presentation/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shopping Mall'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart_sharp))
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is ProductsLoadedState) {
              return OrientationBuilder(builder: (ctx, orientation) {
                return GridView.builder(
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: orientation == Orientation.portrait ? 2 : 3),
                  itemBuilder: (ctx, i) => productGridTile(state.products[i], () {
                    context.read<CartCubit>().addProductToCart(state.products[i]);
                  }),
                  itemCount: state.products.length,
                );
              });
            }
            return const Center(
              child: Text('An error occured!'),
            );
          },
        ),
      ),
    );
  }

  Widget productGridTile(ProductModal product, VoidCallback addToCart) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Image.network(
              product.featuredImage,
              fit: BoxFit.contain,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Text(
                      product.title,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                      onPressed: addToCart,
                      icon: const Icon(
                        Icons.shopping_cart_sharp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
