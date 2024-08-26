import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/cart/cart_controller.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/product/product_controller.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/cart_screen/cart_screen.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/widgets/products_list.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  static const routeName = '/products';

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late CartController cartController;
  late ProductController productController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ProductController>(context, listen: false).onFetchProducts();    
    });
  }

  @override

  Widget build(BuildContext context) {
    productController = Provider.of<ProductController>(context, listen: true);
    cartController = Provider.of<CartController>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product List'),
        actions: [
          badges.Badge(
            badgeContent: Consumer<CartController>(
              builder: (context, value, child) {
                return Text(
                  cartController.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: badges.BadgePosition.bottomStart(start: 30, bottom: 30),
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
      body: ProductsList(
        products: productController.products ?? [],
        cartController: cartController,
        productController: productController,
      ),
    );
  }
}
