import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/cart.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/product.dart';
import 'package:flutter_app_ecommerce/src/features/products/presentation/controller/cart/cart_controller.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({required this.products, required this.cartController});

  final List<Product> products;
  final CartController cartController;

  void saveData(
      int index) async {
    await cartController.insertCart(
      Cart(id: index.toString(), productId: products[index].id, name: products[index].name, description: products[index].description, category: products[index].category, image: products[index].image, price: int.parse(products[index].price), quantity: ValueNotifier(1), material: products[index].material, departament: products[index].departament)
    ).then((value) {
        cartController.addTotalPrice(int.parse(products[index].price).toDouble());
        cartController.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blueGrey.shade200,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image(
                    height: 80,
                    width: 80,
                    image: AssetImage(products[index].image.toString()),
                  ),
                  SizedBox(
                    width: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text:
                                        '${products[index].name.toString()}\n',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                        RichText(
                          maxLines: 1,
                          text: TextSpan(
                              text: 'Description: ',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text: '${products[index].description}\n',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                        RichText(
                          maxLines: 1,
                          text: TextSpan(
                              text: 'Price: ' r"$",
                              style: TextStyle(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text: '${products[index].price}\n',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blueGrey.shade900),
                      onPressed: () {
                        saveData(index);
                      },
                      child: const Text('Add to Cart')),
                ],
              ),
            ),
          );
        });
  }
}
