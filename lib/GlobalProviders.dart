import 'package:provider/provider.dart';
import 'package:vitaflow/core/viewmodels/categories/categories_provider.dart';
import 'package:vitaflow/core/viewmodels/connection/connection.dart';
import 'package:vitaflow/ui/pages/survey/surveyProvider.dart';

import 'core/viewmodels/program/program_provider.dart';

class GlobalProviders {
  /// Register your provider here
  static Future register() async => [
        ChangeNotifierProvider(create: (context) => ConnectionProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => SurveyProvider()),
        ChangeNotifierProvider(create: (context) => ProgramProvider()),
        
      ];
}
