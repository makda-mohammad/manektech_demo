import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_demo/logic/cubits/products_cubit/products_cubit.dart';
import 'package:manektech_demo/presentation/screens/cart_screen.dart';
import 'package:manektech_demo/presentation/screens/home_screen.dart';

import 'logic/cubits/cart_cubit/cart_cubit.dart';

void main() async {
  // ProductsRepository productsRepository = ProductsRepository();
  // final products = await productsRepository.fetchProducts(1);
  // print(products.length);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCubit()),
        BlocProvider(create: (context) => CartCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: {CartScreen.routeName: (context) => const CartScreen()},
      ),
    );
  }
}
