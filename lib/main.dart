import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/GlobalProviders.dart';
import 'package:vitaflow/core/viewmodels/categories/categories_provider.dart';
import 'package:vitaflow/core/viewmodels/classify/classify_provider.dart';
import 'package:vitaflow/core/viewmodels/food/food_provider.dart';
import 'package:vitaflow/core/viewmodels/product/product_provider.dart';
import 'package:vitaflow/core/viewmodels/program/program_provider.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vitaflow/ui/pages/survey/surveyProvider.dart';

import 'injection.dart';
import 'navigation/navigation_utils.dart';
import 'route/route_generator.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'id'; // or any other locale you want to use
  var providers = await GlobalProviders.register();
  await setupLocator();
  tz.initializeTimeZones();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
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
        ...widget.providers,
        ChangeNotifierProvider(create: (create) => CategoryProvider()),
        ChangeNotifierProvider(create: (create) => UserProvider()),
        ChangeNotifierProvider(create: (create) => SurveyProvider()),
        ChangeNotifierProvider(create: (create) => ClassifyProvider()),
        ChangeNotifierProvider(create: (create) => FoodProvider()),
        ChangeNotifierProvider(create: (create) => ProductProvider()),
        ChangeNotifierProvider(create: (create) => ProgramProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: locator<NavigationUtils>().navigatorKey,
        title: 'Vitaflow',
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
