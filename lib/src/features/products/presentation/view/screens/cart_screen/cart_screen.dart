import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/res/colours.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/cart.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/cart/cart_controller.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/view/screens/products_screen/products_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> tapped = [];

  @override
  void initState() {
    super.initState();
    Provider.of<CartController>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, ProductsScreen.routeName);
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: const Text('Ecommerce'),
        actions: [
          badges.Badge(
            badgeContent: Consumer<CartController>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: badges.BadgePosition.bottomStart(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartController>(
              builder: (BuildContext context, provider, widget) {
                if (provider.cart.isEmpty) {
                  return const Center(
                      child: Text(
                    'Your Cart is Empty',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.cart.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colours.primaryColour,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // Image(
                                //   height: 80,
                                //   width: 80,
                                //   image: AssetImage(provider.cart[index].image),
                                // ),
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: 'Name: ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '${provider.cart[index].name}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ]),
                                      ),
                                      SizedBox(height: 4,),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        text: TextSpan(
                                            text: 'Description: ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '${provider.cart[index].description}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ]),
                                      ),
                                      SizedBox(height: 4,),
                                      RichText(
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: 'Price: ' r"$",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '${provider.cart[index].price}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                PlusMinusButtons(
                                  addQuantity: () {
                                    cart.addQuantity(
                                        int.parse(provider.cart[index].id));
                                    cart
                                        .updateCardQuantity(Cart(
                                            id: index.toString(),
                                            productId:
                                                provider.cart[index].productId,
                                            name: provider.cart[index].name,
                                            description: provider
                                                .cart[index].description,
                                            category:
                                                provider.cart[index].category,
                                            image: provider.cart[index].image,
                                            price: provider.cart[index].price,
                                            quantity:
                                                provider.cart[index].quantity,
                                            material:
                                                provider.cart[index].material,
                                            departament: provider
                                                .cart[index].departament))
                                        .then((value) {
                                      setState(() {
                                        cart.addTotalPrice(double.parse(provider
                                            .cart[index].price
                                            .toString()));
                                      });
                                    });
                                  },
                                  deleteQuantity: () {
                                    cart.deleteQuantity(
                                        int.parse(provider.cart[index].id));
                                    cart.removeTotalPrice(double.parse(
                                        provider.cart[index].price.toString()));
                                  },
                                  text:
                                      provider.cart[index].quantity.toString(),
                                ),
                                IconButton(
                                    onPressed: () {
                                      cart.deleteCartItem(
                                          int.parse(provider.cart[index].id));

                                      provider.removeItem(
                                          int.parse(provider.cart[index].id));
                                      provider.removeCounter();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade800,
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
          Consumer<CartController>(
            builder: (BuildContext context, value, Widget? child) {
              final ValueNotifier<double?> totalPrice = ValueNotifier(null);
              for (var element in value.cart) {
                totalPrice.value = (element.price * element.quantity) +
                    (totalPrice.value ?? 0);
              }
              return Column(
                children: [
                  ValueListenableBuilder<double?>(
                      valueListenable: totalPrice,
                      builder: (context, val, child) {
                        return ReusableWidget(
                            title: 'Sub-Total',
                            value: r'$' + (val?.toStringAsFixed(2) ?? '0'));
                      }),
                ],
              );
            },
          )
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment Successful!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: Colours.primaryColour,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Buy',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove, color: Colors.white,)),
        Text(text, style: const TextStyle(color: Colors.white),),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add, color: Colors.white,)),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          Text(value.toString(), style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
