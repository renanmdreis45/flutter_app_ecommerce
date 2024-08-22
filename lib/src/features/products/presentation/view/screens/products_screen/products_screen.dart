import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/services/get_product_providers.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/cart/cart_controller.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/product/product_controller.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/cart_screen/cart_screen.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/widgets/products_list.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  static const routeName = '/products';

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var cartController;
  var productController;
  late List<SingleChildWidget> providers;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      productController = Provider.of<ProductController>(context, listen: false)
          .onFetchProducts();
      providers = await getProviders();
    });
  }

  @override
  Widget build(BuildContext context) {
    productController = Provider.of<ProductController>(context);
    cartController = Provider.of<CartController>(context, listen: false);

    return MultiProvider(
      providers: providers,
      child: Scaffold(
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
            products: productController.products!,
            cartController: cartController),
      ),
    );
  }
}
