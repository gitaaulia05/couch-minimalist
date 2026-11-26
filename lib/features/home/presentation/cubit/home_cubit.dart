import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_item.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/get_promo_banner_usecase.dart';
import '../../domain/usecases/search_products_usecase.dart';
import 'home_state.dart';

/// HomeCubit manages all state for the home/catalog screen:
/// products, categories, search query, cart, and promo banner.
class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetPromoBannerUseCase getPromoBannerUseCase;
  final SearchProductsUseCase searchProductsUseCase;

  HomeCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
    required this.getPromoBannerUseCase,
    required this.searchProductsUseCase,
  }) : super(const HomeState());

  /// Bootstrap — called when the screen is first created.
  Future<void> initialize() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final results = await Future.wait([
        getCategoriesUseCase(),
        getPromoBannerUseCase(),
        getProductsUseCase(categoryId: 'semua'),
      ]);

      emit(state.copyWith(
        status: HomeStatus.loaded,
        categories: results[0] as dynamic,
        banner: results[1] as dynamic,
        products: results[2] as dynamic,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Filter catalog by category.
  Future<void> selectCategory(String categoryId) async {
    if (state.selectedCategoryId == categoryId) return;
    try {
      final products = await getProductsUseCase(categoryId: categoryId);
      if (isClosed) return;
      emit(state.copyWith(
        selectedCategoryId: categoryId,
        searchQuery: '',
        products: products,
      ));
    } catch (e) {
      if (isClosed) return;
    }
  }

  /// Live search - debouncing can be added at the presentation layer.
  Future<void> search(String query) async {
    try {
      final products = query.isEmpty
          ? await getProductsUseCase(categoryId: state.selectedCategoryId)
          : await searchProductsUseCase(query);
      if (isClosed) return;
      emit(state.copyWith(searchQuery: query, products: products));
    } catch (_) {}
  }

  /// Toggle favorite on a product item.
  void toggleFavorite(String productId) {
    final updated = state.products.map((p) {
      if (p.id == productId) return p.copyWith(isFavorite: !p.isFavorite);
      return p;
    }).toList();
    emit(state.copyWith(products: updated));
  }

  /// Add product to cart (adds one copy).
  void addToCart(ProductItem item) {
    final updated = List<ProductItem>.from(state.cartItems)..add(item);
    emit(state.copyWith(cartItems: updated));
  }

  /// Remove one instance of a product from cart.
  void removeFromCart(String productId) {
    final updated = List<ProductItem>.from(state.cartItems);
    final idx = updated.indexWhere((p) => p.id == productId);
    if (idx != -1) updated.removeAt(idx);
    emit(state.copyWith(cartItems: updated));
  }

  /// Clear entire cart.
  void clearCart() {
    emit(state.copyWith(cartItems: []));
  }
}
