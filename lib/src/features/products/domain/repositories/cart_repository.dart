import 'package:flutter_app_ecommerce/core/utils/typedef.dart';

import '../entities/cart.dart';

abstract class CartRepository {
  const CartRepository();

  ResultFuture<Cart> insertCart({required Cart cart});

  ResultFuture<List<Cart>> getCartList();

  ResultFuture<int> updateQuantity({required Cart cart});

  ResultFuture<int> deleteCartItem({required int id});
}
