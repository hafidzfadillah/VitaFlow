import 'package:flutter/material.dart';
import 'package:vitaflow/ui/pages/articleScreen.dart';
import 'package:vitaflow/ui/pages/chatbot.dart';
import 'package:vitaflow/ui/pages/listSport.dart';
import 'package:vitaflow/ui/pages/programScreen.dart';
import 'package:vitaflow/ui/pages/recordFoodScreen.dart';
import 'package:vitaflow/ui/pages/recordSportScreen.dart';
import 'package:vitaflow/ui/pages/recordWaterScreen.dart';
import 'package:vitaflow/ui/pages/sportActionScreen.dart';
import 'package:vitaflow/ui/pages/survey/surveyScreen.dart';
import 'package:vitaflow/ui/pages/vitaPulseScreen.dart';

import '../ui/pages/daftarScreen.dart';
import '../ui/pages/loginScreen.dart';
import '../ui/pages/main_pages.dart';
import '../ui/pages/onboarding.dart';
import '../ui/pages/splashScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/on-boarding':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => DaftarScreen());
      case '/survey':
        return MaterialPageRoute(builder: (_) => SurveyScreen());

      case '/home':
        return MaterialPageRoute(builder: (_) => MainPages());
      case '/chatbot':
        return MaterialPageRoute(builder: (_) => ChatbotScreen());
      case '/food-record':
        return MaterialPageRoute(builder: (_) => RecordFoodScreen());
      case '/article':
        return MaterialPageRoute(builder: (_) => ArticleScreen());

      case '/program':
        return MaterialPageRoute(builder: (_) => ProgramScreen());

      case '/water-record':
        return MaterialPageRoute(builder: (_) => RecordWaterScreen());
      case '/vita-pulse':
        return MaterialPageRoute(builder: (_) => VitaPulseScreen());
      case '/record-sport':
        return MaterialPageRoute(builder: (_) => RecordSportScreen());
      case '/list-sport':
        return MaterialPageRoute(
            builder: (_) => ListSport(data: args as Map<String, dynamic>));
      case '/action-sport':
        return MaterialPageRoute(
            builder: (_) =>
                SportActionScreen(data: args as List<Map<String, dynamic>>));

      // case '/product-detail':
      //   return MaterialPageRoute(builder: (_) => ProductDetailScreen());
      // case '/cart':
      //   return MaterialPageRoute(builder: (_) => CartScreen());
      // case '/address':
      //   return MaterialPageRoute(builder: (_) => AddressScreen());
      // case '/add-address':
      //   return MaterialPageRoute(builder: (_) => AddAddress());
      // case '/checkout':
      //   return MaterialPageRoute(builder: (_) => CheckOutScreen());
      // case '/category-product':
      //   return MaterialPageRoute(builder: (_) => CategoryProduct());
      // case '/payment-list':
      //   return MaterialPageRoute(builder: (_) => PaymentListScreen());
      // case '/load-payment':
      //   return MaterialPageRoute(builder: (_) => LoadPaymentScreen());
      // case '/payment-code':
      //   return MaterialPageRoute(builder: (_) => PaymentCodeScreen());
      // case '/recipe-detail':
      //   return MaterialPageRoute(builder: (_) => RecipeDetailScreen());
      // case '/recipe':
      //   return MaterialPageRoute(builder: (_) => Discover());
      // case '/list-outlet':
      //   return MaterialPageRoute(builder: (_) => ListOutlet());
      // case '/no-internet':
      //   return MaterialPageRoute(builder: (_) => NoInternetConnection());
      // case '/search-product':
      //   return MaterialPageRoute(builder: (_) => ProductSearchScreen());
      // case '/search-location':
      //   return MaterialPageRoute(builder: (_) => SearchLocation());
      // case '/additional-information':
      //   return MaterialPageRoute(builder: (_) => AdditionalInformation());
      // case '/track-driver':
      // return MaterialPageRoute(builder: (_) => TrackDriver());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('error'),
        ),
        body: Center(
          child: Text('Erorr'),
        ),
      );
    });
  }
}
