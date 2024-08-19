part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class ClearCart extends CartEvent {}

class CartUpdated extends CartEvent {
  final List<Product> updatedCart;

  CartUpdated(this.updatedCart);

  @override
  List<Object> get props => [updatedCart];
}

class AddProductToCart extends CartEvent {
  final Product product;

  AddProductToCart(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProductFromCart extends CartEvent {
  final Product product;

  RemoveProductFromCart(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateProductQuant extends CartEvent {
  final Product product;

  UpdateProductQuant(this.product);

  @override
  List<Object> get props => [product];
}
