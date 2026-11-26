import '../../domain/entities/product_category.dart';
import '../../domain/entities/product_item.dart';
import '../../domain/entities/promo_banner.dart';

enum HomeStatus { initial, loading, loaded, failure }

/// Immutable state for the home/catalog screen.
class HomeState {
  final HomeStatus status;
  final List<ProductItem> products;
  final List<ProductCategory> categories;
  final PromoBanner? banner;
  final String selectedCategoryId;
  final String searchQuery;
  final List<ProductItem> cartItems;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.products = const [],
    this.categories = const [],
    this.banner,
    this.selectedCategoryId = 'semua',
    this.searchQuery = '',
    this.cartItems = const [],
    this.errorMessage,
  });

  /// Total items in cart
  int get cartCount => cartItems.length;

  /// Total cart price
  int get cartTotal => cartItems.fold(0, (sum, item) {
        final cleaned = item.price.replaceAll(RegExp(r'[^0-9]'), '');
        return sum + (int.tryParse(cleaned) ?? 0);
      });

  /// Formatted cart total (Rp x.xxx.xxx)
  String get formattedCartTotal {
    final total = cartTotal;
    final str = total.toString();
    final buffer = StringBuffer('Rp ');
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  HomeState copyWith({
    HomeStatus? status,
    List<ProductItem>? products,
    List<ProductCategory>? categories,
    PromoBanner? banner,
    String? selectedCategoryId,
    String? searchQuery,
    List<ProductItem>? cartItems,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      banner: banner ?? this.banner,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
      cartItems: cartItems ?? this.cartItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          selectedCategoryId == other.selectedCategoryId &&
          searchQuery == other.searchQuery &&
          cartItems == other.cartItems;

  @override
  int get hashCode =>
      status.hashCode ^
      selectedCategoryId.hashCode ^
      searchQuery.hashCode ^
      cartItems.hashCode;
}
