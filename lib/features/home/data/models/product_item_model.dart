import '../../domain/entities/product_item.dart';

/// Data model for ProductItem with factory constructors for local seed data.
class ProductItemModel extends ProductItem {
  const ProductItemModel({
    required super.id,
    required super.name,
    required super.price,
    required super.formattedPrice,
    required super.rating,
    required super.imageUrl,
    required super.category,
    super.isFavorite = false,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      formattedPrice: json['formatted_price'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      category: json['category'] as String,
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'formatted_price': formattedPrice,
        'rating': rating,
        'image_url': imageUrl,
        'category': category,
        'is_favorite': isFavorite,
      };
}
