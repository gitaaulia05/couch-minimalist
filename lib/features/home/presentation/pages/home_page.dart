import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/datasources/home_local_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/get_promo_banner_usecase.dart';
import '../../domain/usecases/search_products_usecase.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/category_filter_row.dart';
import '../widgets/floating_order_bar.dart';
import '../widgets/home_header_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/promo_banner_card.dart';
import '../widgets/search_filter_bar.dart';

/// Catalog landing page for SOFI Furniture.
/// Wired with HomeCubit via BlocProvider.create() factory.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// DI factory — sets up all dependencies for the feature.
  static Widget create() {
    final dataSource = HomeLocalDataSourceImpl();
    final repository = HomeRepositoryImpl(localDataSource: dataSource);
    return BlocProvider(
      create: (_) => HomeCubit(
        getProductsUseCase: GetProductsUseCase(repository),
        getCategoriesUseCase: GetCategoriesUseCase(repository),
        getPromoBannerUseCase: GetPromoBannerUseCase(repository),
        searchProductsUseCase: SearchProductsUseCase(repository),
      )..initialize(),
      child: const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _HomePageView();
  }
}

class _HomePageView extends StatefulWidget {
  const _HomePageView();

  @override
  State<_HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<_HomePageView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        return Scaffold(
          backgroundColor: AppColors.surface,
          body: SafeArea(
            child: Stack(
              children: [
                // Scrollable content
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // ── Header & Search ──────────────────────────────────────
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeHeaderBar(
                              cartCount: state.cartCount,
                              onCartTap: () {
                                _showCartSnackBar(context, state);
                              },
                            ),
                            const SizedBox(height: 16),
                            SearchFilterBar(
                              controller: _searchController,
                              onSearchChanged: (q) => cubit.search(q),
                              onFilterTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Filter akan segera hadir'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ── Promo Banner ─────────────────────────────────────────
                    if (state.banner != null)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                          child: PromoBannerCard(banner: state.banner!),
                        ),
                      ),

                    // ── Category Filter ───────────────────────────────────────
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: CategoryFilterRow(
                          categories: state.categories,
                          selectedId: state.selectedCategoryId,
                          onCategorySelected: cubit.selectCategory,
                        ),
                      ),
                    ),

                    // ── Catalog Header Row ─────────────────────────────────────
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Katalog Sofa',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                                letterSpacing: -0.3,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Terpopuler',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.onTertiaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                const Icon(
                                  Icons.expand_more,
                                  size: 16,
                                  color: AppColors.onTertiaryContainer,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ── Loading / Empty / Products Grid ──────────────────────
                    if (state.status == HomeStatus.loading)
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.onTertiaryContainer,
                              ),
                            ),
                          ),
                        ),
                      )
                    else if (state.products.isEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.weekend_outlined,
                                  size: 48,
                                  color: AppColors.secondary,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Produk tidak ditemukan',
                                  style: TextStyle(
                                    color: AppColors.secondary.withValues(
                                        alpha: 0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          16,
                          16,
                          state.cartCount > 0 ? 110 : 32,
                        ),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final product = state.products[index];
                              return ProductCard(
                                product: product,
                                onFavoriteTap: () =>
                                    cubit.toggleFavorite(product.id),
                                onAddToCart: () => cubit.addToCart(product),
                              );
                            },
                            childCount: state.products.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 0.68,
                          ),
                        ),
                      ),
                  ],
                ),

                // ── Floating Order Bar ───────────────────────────────────────
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    offset: state.cartCount > 0
                        ? Offset.zero
                        : const Offset(0, 1.5),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: state.cartCount > 0 ? 1.0 : 0.0,
                      child: FloatingOrderBar(
                        itemCount: state.cartCount,
                        formattedTotal: state.formattedCartTotal,
                        onOrderTap: () =>
                            _showOrderConfirmation(context, state, cubit),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCartSnackBar(BuildContext context, HomeState state) {
    if (state.cartCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang masih kosong'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${state.cartCount} item di keranjang — ${state.formattedCartTotal}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showOrderConfirmation(
      BuildContext context, HomeState state, HomeCubit cubit) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Konfirmasi Pesanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${state.cartCount} produk senilai ${state.formattedCartTotal}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      cubit.clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Pesanan berhasil dikirim! Terima kasih 🎉'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.onTertiaryContainer,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Pesan Sekarang',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
