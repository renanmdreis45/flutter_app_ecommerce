part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Product> cart;
  final int totalPrice;

  CartLoaded({
    required this.cart,
    required this.totalPrice,
  });

  @override
  List<Object> get props => [cart, totalPrice];
}

class CartError extends CartState {
  final String error;

  CartError(this.error);

  @override
  List<Object> get props => [error];
}
