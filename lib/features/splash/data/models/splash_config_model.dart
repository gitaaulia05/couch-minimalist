import '../../domain/entities/splash_config.dart';
import '../../../../core/constants/app_strings.dart';

/// Data model representing splash configuration, mapping data to domain entities.
class SplashConfigModel extends SplashConfig {
  const SplashConfigModel({
    required super.appName,
    required super.tagline,
    required super.origin,
    required super.specifications,
    required super.brandMetaTitle,
    required super.version,
  });

  factory SplashConfigModel.defaultConfig() {
    return const SplashConfigModel(
      appName: AppStrings.appName,
      tagline: AppStrings.brandTagline,
      origin: AppStrings.originIndicator,
      specifications: AppStrings.editorialSpecs,
      brandMetaTitle: AppStrings.brandMetaTitle,
      version: AppStrings.appVersion,
    );
  }

  factory SplashConfigModel.fromJson(Map<String, dynamic> json) {
    return SplashConfigModel(
      appName: json['app_name'] as String? ?? AppStrings.appName,
      tagline: json['tagline'] as String? ?? AppStrings.brandTagline,
      origin: json['origin'] as String? ?? AppStrings.originIndicator,
      specifications: (json['specifications'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          AppStrings.editorialSpecs,
      brandMetaTitle:
          json['brand_meta_title'] as String? ?? AppStrings.brandMetaTitle,
      version: json['version'] as String? ?? AppStrings.appVersion,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'app_name': appName,
      'tagline': tagline,
      'origin': origin,
      'specifications': specifications,
      'brand_meta_title': brandMetaTitle,
      'version': version,
    };
  }
}
