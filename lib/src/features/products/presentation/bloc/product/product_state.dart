import 'package:equatable/equatable.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  final bool? isLoading;

  ProductLoading({this.isLoading});

  @override
  List<Object?> get props => [this.isLoading];
}

class ProductDone extends ProductState {
  final Product? product;

  ProductDone({this.product});

  @override
  List<Object?> get props => [this.product];
}

class ProductError extends ProductState {
  final String? message;

  ProductError(this.message);

  @override
  List<Object?> get props => [this.message];
}

class ProductsListLoading extends ProductState {
  final bool? isLoading;

  ProductsListLoading({this.isLoading});

  @override
  List<Object?> get props => [this.isLoading];
}

class ProductsListDone extends ProductState {
  final List<Product>? products;

  ProductsListDone({
    this.products,
  });

  @override
  List<Object?> get props => [this.products];
}

class ProductsListError extends ProductState {
  final String? message;

  ProductsListError({this.message});

  @override
  List<Object?> get props => [this.message];
}
