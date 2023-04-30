import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/global/cons.dart';
import 'package:vitaflow/ui/home/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();

    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    getInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  getInit() async {
    Timer(Duration(seconds: 3), () {
      if (_connectionStatus == ConnectivityResult.none) {
        Navigator.pushNamed(context, '/no-internet');
      }
    });

    // await Provider.of<MapProvider>(context, listen: false).initLocation();

    // await Provider.of<CategoryProvider>(context, listen: false).getCategory();
    // await Provider.of<ProductProvider>(context, listen: false).getProduct();
    // await Provider.of<RecipeProvider>(context, listen: false).getRecipe();
    // // await Provider.of<CategoryProductProviders>(context, listen: false)
    // //     .getCategoriesProduct();
    // await Provider.of<VoucherProvider>(context, listen: false)
    //     .getAvailableVoucher();

    final prefs = await SharedPreferences.getInstance();
    prefs.get('token');

    print(prefs);
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, '/on-boarding'));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (ctx, orient, type) {
      return Scaffold(
        backgroundColor: primaryColor,
        body: Stack(children: [
          Center(
            child: Text(
              '$appName',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text(
                'Version $appVersion',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontSize: captionSize),
              ),
            ),
            alignment: Alignment.bottomCenter,
          )
        ]),
      );
    });
  }
}
