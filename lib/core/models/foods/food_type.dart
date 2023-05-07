import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/user/user_food.dart';

class FoodType extends Serializable {
  final String type;
  final List<UserFood> userFood;

  FoodType({
    required this.type,
    required this.userFood,

   
  });

  factory FoodType.fromJson(Map<String, dynamic> json) => FoodType(
      
        type: json['type'] ?? "",
        userFood: List<UserFood>.from(
            json["user_food"].map((x) => UserFood.fromJson(x))),
      );
  

  @override
  Map<String, dynamic> toJson() => {
        "type": type,
        "user_food": List<dynamic>.from(userFood.map((x) => x.toJson())),
      
      };
}
