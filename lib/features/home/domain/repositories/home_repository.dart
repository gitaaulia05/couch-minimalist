import '../entities/product_item.dart';
import '../entities/product_category.dart';
import '../entities/promo_banner.dart';

/// Abstract contract for the Home/Catalog repository.
abstract class HomeRepository {
  Future<List<ProductItem>> getProducts({String? categoryId});
  Future<List<ProductCategory>> getCategories();
  Future<PromoBanner> getPromoBanner();
  Future<List<ProductItem>> searchProducts(String query);
}
