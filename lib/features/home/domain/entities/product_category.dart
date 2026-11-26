/// Domain entity for a product category filter.
class ProductCategory {
  final String id;
  final String label;

  const ProductCategory({required this.id, required this.label});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
