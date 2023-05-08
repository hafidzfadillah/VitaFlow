import 'package:vitaflow/core/models/api/api_result_model.dart';

class ProductBannerModel extends Serializable {
  final String title;
  final String buttonText;
  final String image;
  final String background;
  final String lineColor;

  ProductBannerModel({
    required this.title,
    required this.buttonText,
    required this.image,
    required this.background,
    required this.lineColor,
  });

  factory ProductBannerModel.fromJson(Map<String, dynamic> json) =>
      ProductBannerModel(
        title: json['title'] ?? "",
        buttonText: json['buttonText'] ?? "",
        image: json['image'] ?? "",
        background: json['background'] ?? "",
        lineColor: json['lineColor'] ?? "",
      );

  @override
  Map<String, dynamic> toJson() => {
        "title": title,
        "buttonText": buttonText,
        "image": image,
        "backgroundColor": background,
        "lineColor": lineColor,
      };
}
