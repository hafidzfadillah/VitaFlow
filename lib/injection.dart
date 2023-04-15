import 'package:get_it/get_it.dart';

import 'navigation/navigation_utils.dart';


GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Registering api

  locator.registerSingleton(NavigationUtils());

  /// Registering services
}
