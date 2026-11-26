/// Domain entity for the promo banner displayed at the top of the catalog.
class PromoBanner {
  final String id;
  final String badgeText;
  final String title;
  final String subtitle;
  final String imageUrl;

  const PromoBanner({
    required this.id,
    required this.badgeText,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}
