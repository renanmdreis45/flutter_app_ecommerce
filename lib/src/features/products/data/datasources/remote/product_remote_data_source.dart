import 'dart:convert';

import 'package:flutter_app_ecommerce/core/constants/constants.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/data/models/product_model.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/product.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProducts();

  Future<Product> getProductById({required String id});
}

const kGetProductsEndpoint = '/devnology/brazilian_provider';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<List<ProductModel>> getProducts() async {
    final response =
        await _client.get(Uri.http(kBaseProductsUrl, kGetProductsEndpoint));
    print(response);
    return List<DataMap>.from(jsonDecode(response.body))
        .map((userData) => ProductModel.fromMap(userData))
        .toList();
  }

  @override
  Future<ProductModel> getProductById({required String id}) async {
    final response = await _client
        .get(Uri.http(kBaseProductsUrl, '$kGetProductsEndpoint/$id'));

    return ProductModel.fromJson(response.body);
  }
}
