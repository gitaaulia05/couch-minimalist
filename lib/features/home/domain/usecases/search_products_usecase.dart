import '../entities/product_item.dart';
import '../repositories/home_repository.dart';

/// Use case to search products by keyword.
class SearchProductsUseCase {
  final HomeRepository _repository;

  const SearchProductsUseCase(this._repository);

  Future<List<ProductItem>> call(String query) async {
    return await _repository.searchProducts(query);
  }
}
