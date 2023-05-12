import 'package:get_it/get_it.dart';
import 'package:vitaflow/core/data/api.dart';
import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/services/article_service.dart';
import 'package:vitaflow/core/services/categories_service.dart';
import 'package:vitaflow/core/services/chat_service.dart';
import 'package:vitaflow/core/services/food_service.dart';
import 'package:vitaflow/core/services/product_service.dart';
import 'package:vitaflow/core/services/user_service.dart';

import 'core/services/survey_services.dart';
import 'package:vitaflow/navigation/navigation_utils.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Registering api
  ///
  if (locator.isRegistered(instance: Api()) == false) {
    locator.registerSingleton(Api());
  }
  if (locator.isRegistered(instance: BaseAPI()) == false) {
    locator.registerSingleton(BaseAPI());
  }

  locator.registerSingleton(NavigationUtils());


  /// Registering services
  ///
  locator.registerSingleton(CategoryService(locator<BaseAPI>()));
  locator.registerSingleton(UserService(locator<BaseAPI>()));
  locator.registerSingleton(SurveyService(locator<BaseAPI>()));
  locator.registerSingleton(ProductService(locator<BaseAPI>()));
  locator.registerSingleton(ArticleService(locator<BaseAPI>()));
  locator.registerSingleton(FoodService(locator<BaseAPI>()));
  locator.registerSingleton(ChatService(locator<BaseAPI>()));
}
