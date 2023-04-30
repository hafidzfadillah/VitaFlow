import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/GlobalProviders.dart';
import 'package:vitaflow/core/viewmodels/categories/categories_provider.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:provider/single_child_widget.dart';

import 'injection.dart';
import 'navigation/navigation_utils.dart';
import 'route/route_generator.dart';
import 'package:intl/intl.dart';

void main() async {
  Intl.defaultLocale = 'id'; // or any other locale you want to use
  var providers = await GlobalProviders.register();

  await setupLocator();
  runApp(MyApp(
    providers: providers,
  ));
}

class MyApp extends StatefulWidget {
  final List<dynamic> providers;

  const MyApp({
    Key? key,
    required this.providers,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => CategoryProvider()),
        ChangeNotifierProvider(create: (create ) => UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: locator<NavigationUtils>().navigatorKey,
        title: 'Freshmarket',
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
