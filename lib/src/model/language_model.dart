class LanguageModel {
  String imageUrl;
  String languageName;
  String languageCode;
  String? countryCode;

  LanguageModel({
    required this.imageUrl,
    required this.languageName,
    this.countryCode,
    required this.languageCode,
  });
}
