import '../entities/product_item.dart';
import '../repositories/home_repository.dart';

/// Use case to fetch products, optionally filtered by category.
class GetProductsUseCase {
  final HomeRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<List<ProductItem>> call({String? categoryId}) async {
    return await _repository.getProducts(categoryId: categoryId);
  }
}
