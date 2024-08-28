import 'package:flutter_app_ecommerce/core/utils/typedef.dart';

import '../entities/purchase.dart';

abstract class PurchaseRepository {
  const PurchaseRepository();

  ResultVoid buyProduct({required String productId, required String name, required String description, required String category, required String price, required int quantity, required String material, required String department, required String username});

  ResultFuture<List<Purchase>> getPurchaseList();
}
