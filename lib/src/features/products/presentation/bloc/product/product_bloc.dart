import 'package:equatable/equatable.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/product.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/usecases/product/get_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc({required this.getProducts}) : super(ProductsInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductsLoading());
    try {
      final products = (await getProducts()) as List<Product>;
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}