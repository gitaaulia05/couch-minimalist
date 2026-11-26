/// Domain entity representing a sofa product item.
class ProductItem {
  final String id;
  final String name;
  final String price;
  final String formattedPrice;
  final double rating;
  final String imageUrl;
  final String category;
  final bool isFavorite;

  const ProductItem({
    required this.id,
    required this.name,
    required this.price,
    required this.formattedPrice,
    required this.rating,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
  });

  ProductItem copyWith({
    String? id,
    String? name,
    String? price,
    String? formattedPrice,
    double? rating,
    String? imageUrl,
    String? category,
    bool? isFavorite,
  }) {
    return ProductItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      formattedPrice: formattedPrice ?? this.formattedPrice,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
