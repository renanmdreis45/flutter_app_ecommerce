import 'dart:convert';

import 'package:flutter_app_ecommerce/core/errors/exceptions.dart';
import 'package:flutter_app_ecommerce/core/utils/constants.dart';
import 'package:flutter_app_ecommerce/core/utils/typedef.dart';
import 'package:flutter_app_ecommerce/src/features/products/data/models/purchase_model.dart';
import 'package:flutter_app_ecommerce/src/features/products/domain/entities/purchase.dart';
import 'package:http/http.dart' as http;

abstract class PurchaseRemoteDataSource {
  Future<void> buyProduct({
    required String productId,
    required String name,
    required String description,
    required String category,
    required String price,
    required int quantity,
    required String material,
    required String departament,
  });
  Future<List<Purchase>> getPurchases();
}

const kGetPurchasesEndpoint = '/purchases';
const kCreatePurchaseEndpoint = '/purchase';

class PurchaseRemoteDataSourceImpl implements PurchaseRemoteDataSource {
  const PurchaseRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> buyProduct({
    required String productId,
    required String name,
    required String description,
    required String category,
    required String price,
    required int quantity,
    required String material,
    required String departament,
  }) async {
    try {
      final response =
          await _client.post(Uri.parse('$kBaseApiUrl$kCreatePurchaseEndpoint'),
              body: jsonEncode({
                'id': productId,
                'name': name,
                'description': description,
                'category': category,
                'price': price,
                'quantity': quantity,
                'material': material,
                'departament': departament,
              }));

      print('Compra realizada: ${response}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }


  @override
  Future<List<PurchaseModel>> getPurchases() async {
    final response =
        await _client.get(Uri.http(kBaseApiUrl, kGetPurchasesEndpoint));
    
    return List<DataMap>.from(jsonDecode(response.body))
        .map((userData) => PurchaseModel.fromMap(userData))
        .toList();
  }
}
