import 'package:flutter/cupertino.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/cart.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/delete_cart_item.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/get_cart_list.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/insert_cart.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/cart/update_quantity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController with ChangeNotifier {
  final GetCartList getCartList;
  final UpdateQuantity updateQuantity;
  final DeleteCartItem deleteCartItem;
  final InsertCart insertCart;

  int _counter = 0;
  int _quantity = 1;
  int get counter => _counter;
  int get quantity => _quantity;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  List<Cart> cart = [];

  CartController({
    required this.getCartList,
    required this.updateQuantity,
    required this.deleteCartItem,
    required this.insertCart,
  });

  Future<List<Cart>> getData() async {
    final result = await getCartList();

    result.fold((failure) {
      print("Falha ao retornar os produtos do carrinho: $failure");
    }, (cartList) {
      cart = cartList;
    });
    notifyListeners();
    return cart;
  }

  void _setPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', _counter);
    prefs.setInt('item_quantity', _quantity);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_items') ?? 0;
    _quantity = prefs.getInt('item_quantity') ?? 1;
    _totalPrice = prefs.getDouble('total_price') ?? 0;
  }

  void addCounter() {
    _counter++;
    _setPrefsItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefsItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefsItems();
    return _counter;
  }

  void addQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart[index].quantity = cart[index].quantity + 1;
    _setPrefsItems();
    notifyListeners();
  }

  void deleteQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    final currentQuantity = cart[index].quantity;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cart[index].quantity = currentQuantity - 1;
    }
    _setPrefsItems();
    notifyListeners();
  }

  void removeItem(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart.removeAt(index);
    _setPrefsItems();
    notifyListeners();
  }

  int getQuantity(int quantity) {
    _getPrefsItems();
    return _quantity;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefsItems();
    return _totalPrice;
  }

  Future<int> updateCardQuantity(Cart cart) async {
    final newQuant = await updateQuantity(cart);
    return newQuant as int;
  }

  Future<int> deleteCardProduct(int id) async {
    final newQuant = await deleteCartItem(id);
    return newQuant as int;
  }

  Future<void> saveCart(Cart cart) async {
    final result = await insertCart.call(cart);
    result.fold(
      (failure) {
        print("Falha ao adicionar o produto no carrinho: $failure");
      },
      (_) {
        print(cart);
      },
    );
  }
}
