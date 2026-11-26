import '../../domain/entities/product_category.dart';
import '../../domain/entities/product_item.dart';
import '../../domain/entities/promo_banner.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ProductItem>> getProducts({String? categoryId}) async {
    return await localDataSource.getProducts(categoryId: categoryId);
  }

  @override
  Future<List<ProductCategory>> getCategories() async {
    return await localDataSource.getCategories();
  }

  @override
  Future<PromoBanner> getPromoBanner() async {
    return await localDataSource.getPromoBanner();
  }

  @override
  Future<List<ProductItem>> searchProducts(String query) async {
    return await localDataSource.searchProducts(query);
  }
}
