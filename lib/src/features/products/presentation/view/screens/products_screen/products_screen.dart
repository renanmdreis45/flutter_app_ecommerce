import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/bloc/product/product_bloc.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/cart/cart_controller.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/cart_screen/cart_screen.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/widgets/products_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product List'),
        actions: [
          Badge(
            badgeContent: Consumer<CartController>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductsLoaded) {
          return ProductsList(
              products: state.products , cartController: cart);
        } else {
          return const Center(child: Text('Estamos com problema ao retornar os produtos. Tente novamente depois'),);
        }
      }),
    );
  }
}
