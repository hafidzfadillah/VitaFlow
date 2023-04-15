import 'package:flutter/material.dart';

import 'injection.dart';
import 'navigation/navigation_utils.dart';
import 'route/route_generator.dart';

void main() async {
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        navigatorKey: locator<NavigationUtils>().navigatorKey,
        title: 'Freshmarket',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
