import '../../domain/entities/product_category.dart';
import '../../domain/entities/promo_banner.dart';
import '../models/product_item_model.dart';

abstract class HomeLocalDataSource {
  Future<List<ProductItemModel>> getProducts({String? categoryId});
  Future<List<ProductCategory>> getCategories();
  Future<PromoBanner> getPromoBanner();
  Future<List<ProductItemModel>> searchProducts(String query);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  /// Static product seed data matching the HTML design exactly.
  static const List<ProductItemModel> _allProducts = [
    ProductItemModel(
      id: 'p1',
      name: 'Sofa Nordik 3-Seater',
      price: '4250000',
      formattedPrice: 'Rp 4.250.000',
      rating: 4.9,
      category: 'Semua',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA2gfNUn22l-fSFtIJc3pTDudzG-1PfJ8vOZE_Rk--rxOcZ008irsOXJJj1nqTjA5cEBNROaL-h1w5KLsjXmT-pPNv29ukHgpWNIC_LErmG55AHxLyIfujBdy7_EC9w8Atnjn3H256kZV60O0WJX-iNFEjTkz_z9vLPVaPTurUU_BF5lWNFEsKYzBcHuvtvB62CzFhVgLUHX4pTKWN_AVv4PU4bbYWOojJwjuN3cwyh',
      isFavorite: true,
    ),
    ProductItemModel(
      id: 'p2',
      name: 'Sofa L-Shape Oslo',
      price: '6800000',
      formattedPrice: 'Rp 6.800.000',
      rating: 4.8,
      category: 'L-Shape',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB0-w604w4CqMtiMj9mtRnISkq_d3YnA1H7ywFdAJTJrqW9bOq-HAuv_Ah3jNnfZVDRwKQfW4NSN-YSEShJg0PeOuGNcD779nAt3aVkDGeGDmszVArghnKGExupMy0aaNTF43APk56d0kBcRFasrVSL5fJ1-FnUTm5aXpS7HqNKcI9T3un4_CkXsoNgex0_MOoQJHaFE2BLdaHmY8RaOCf-0j9Nz-SYzs9CAcu5QQlZ',
    ),
    ProductItemModel(
      id: 'p3',
      name: 'Sofa Bed Kyoto',
      price: '3150000',
      formattedPrice: 'Rp 3.150.000',
      rating: 4.7,
      category: 'Sofa Bed',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAN1VErJqHKQjQyfEEnrA89illaxabiUs-FUWChCYO4oHJ0WLALU5OuXuvC3W3RUmhi0Y1I8yPKfoz9rpqgH8xIY014Mjqvy6aPCXKrDGf4qMqsGrHYwBpAs_eLXXbmVpFIWD113ZYHkwu-2VPCNmciV-6IgHRkrMq_fMOPsvd7Zmuqb4C-59QxlYiGs8ktdrMxyfmDS4t8-T1CNVN9x5o061ce6DqFwYMRhPXh',
    ),
    ProductItemModel(
      id: 'p4',
      name: 'Armchair Velvet',
      price: '1950000',
      formattedPrice: 'Rp 1.950.000',
      rating: 4.9,
      category: 'Velvet',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA026DCQ7Svjfr-4xHPU-0EuArzW-aVRKMFVyREfp-9acEf0gti8CXNmk8DAXJjFvn1mHuWinmMf-CG9Od8Qorl5_HuBf4v7FHIeygKiaYhDlrplhkLee90k0K1zlX-LKRG9rvoyK1z69PIxokQb1MYgLY3QmL8fY-1vgDw3znwh5FE8eKsskUXC38PYGZQ6XYc4aKyT3d01WUt-nOowYm8j6LHo5MTvUN30fjtdjpp',
    ),
    ProductItemModel(
      id: 'p5',
      name: 'Sofa Minimalis Zen',
      price: '2850000',
      formattedPrice: 'Rp 2.850.000',
      rating: 4.6,
      category: 'Minimalis',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA2gfNUn22l-fSFtIJc3pTDudzG-1PfJ8vOZE_Rk--rxOcZ008irsOXJJj1nqTjA5cEBNROaL-h1w5KLsjXmT-pPNv29ukHgpWNIC_LErmG55AHxLyIfujBdy7_EC9w8Atnjn3H256kZV60O0WJX-iNFEjTkz_z9vLPVaPTurUU_BF5lWNFEsKYzBcHuvtvB62CzFhVgLUHX4pTKWN_AVv4PU4bbYWOojJwjuN3cwyh',
    ),
    ProductItemModel(
      id: 'p6',
      name: 'Sofa 2-Seater Copenhagen',
      price: '3750000',
      formattedPrice: 'Rp 3.750.000',
      rating: 4.8,
      category: '2-Seater',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB0-w604w4CqMtiMj9mtRnISkq_d3YnA1H7ywFdAJTJrqW9bOq-HAuv_Ah3jNnfZVDRwKQfW4NSN-YSEShJg0PeOuGNcD779nAt3aVkDGeGDmszVArghnKGExupMy0aaNTF43APk56d0kBcRFasrVSL5fJ1-FnUTm5aXpS7HqNKcI9T3un4_CkXsoNgex0_MOoQJHaFE2BLdaHmY8RaOCf-0j9Nz-SYzs9CAcu5QQlZ',
    ),
  ];

  static const List<ProductCategory> _categories = [
    ProductCategory(id: 'semua', label: 'Semua'),
    ProductCategory(id: 'minimalis', label: 'Minimalis'),
    ProductCategory(id: 'sofa-bed', label: 'Sofa Bed'),
    ProductCategory(id: 'l-shape', label: 'L-Shape'),
    ProductCategory(id: 'velvet', label: 'Velvet'),
    ProductCategory(id: '2-seater', label: '2-Seater'),
  ];

  static const PromoBanner _banner = PromoBanner(
    id: 'b1',
    badgeText: 'PROMO SPESIAL',
    title: 'Diskon 30% Sofa Nordik',
    subtitle: 'Gratis ongkir area Bandung',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAXoWZut2GzPcJqc-RMl1Oe9VF46rOEJGMDB1NJR6jO98yD7uWnI4IpaZm7eZcGgbEtu2bkob-rQLDN4wl6gMu6JjhOivm1jM-Hrqb-yY6vPiGigny_2ckYlx2siAT2YgCYwsH3kal-NiKaWVWQlw1xXcsFS3ga3XoUiaAdal4OnfMEvZWJ-LR7VnrS89ikkq7kq4AfZ5NXrEKCT3mZP0wz8KuWRdcboHh0kvkMBviJ',
  );

  @override
  Future<List<ProductItemModel>> getProducts({String? categoryId}) async {
    await Future.delayed(const Duration(milliseconds: 60));
    if (categoryId == null || categoryId == 'semua') return _allProducts;

    final categoryFilter = categoryId.toLowerCase();
    return _allProducts.where((p) {
      return p.category.toLowerCase() == categoryFilter ||
          p.name.toLowerCase().contains(categoryFilter);
    }).toList();
  }

  @override
  Future<List<ProductCategory>> getCategories() async {
    return _categories;
  }

  @override
  Future<PromoBanner> getPromoBanner() async {
    return _banner;
  }

  @override
  Future<List<ProductItemModel>> searchProducts(String query) async {
    if (query.trim().isEmpty) return _allProducts;
    final lower = query.toLowerCase();
    return _allProducts
        .where((p) =>
            p.name.toLowerCase().contains(lower) ||
            p.category.toLowerCase().contains(lower))
        .toList();
  }
}
