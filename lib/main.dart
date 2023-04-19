import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

import 'injection.dart';
import 'navigation/navigation_utils.dart';
import 'route/route_generator.dart';
import 'package:intl/intl.dart';

void main() async {
  Intl.defaultLocale = 'id'; // or any other locale you want to use

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
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
