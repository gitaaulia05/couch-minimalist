/// Domain entity representing the splash configuration and metadata.
class SplashConfig {
  final String appName;
  final String tagline;
  final String origin;
  final List<String> specifications;
  final String brandMetaTitle;
  final String version;

  const SplashConfig({
    required this.appName,
    required this.tagline,
    required this.origin,
    required this.specifications,
    required this.brandMetaTitle,
    required this.version,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashConfig &&
          runtimeType == other.runtimeType &&
          appName == other.appName &&
          tagline == other.tagline &&
          origin == other.origin &&
          brandMetaTitle == other.brandMetaTitle &&
          version == other.version;

  @override
  int get hashCode =>
      appName.hashCode ^
      tagline.hashCode ^
      origin.hashCode ^
      brandMetaTitle.hashCode ^
      version.hashCode;
}
