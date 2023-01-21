import 'package:najikkopasal/api/productapi.dart';
import 'package:najikkopasal/response/order_response.dart';
import 'package:najikkopasal/response/product_response.dart';

class ProductRepository {
  Future<ProductResponse?> getproducts(
      {String? keyword, String? category}) async {
    return ProductAPI().getproduct(keywords: keyword, category: category);
  }

  Future<ProductResponse?> getproduct(
     ) async {
    return ProductAPI().getproducts();
  }

  Future<bool> givereview(String productId, String comment, int rating) {
    return ProductAPI().giveproductreview(productId, comment, rating);
  }

  Future<OrderResponse?> getOrderHistory() async {
    return ProductAPI().getOrderHistory();
  }


}
