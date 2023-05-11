// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/core/viewmodels/connection/connection.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CaloriRow.dart';
import 'package:vitaflow/ui/widgets/DatePicker.dart';
import 'package:vitaflow/ui/widgets/loading/LoadingSingleBox.dart';
import 'package:vitaflow/ui/widgets/mission_section.dart';
import 'package:vitaflow/ui/widgets/NutrionInfoBox.dart';
import 'package:vitaflow/ui/widgets/NutritionBar.dart';
import 'package:vitaflow/ui/widgets/top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int point = 0;
  String level = '';

  @override
  void initState() {
    super.initState();
    getData();
    print('trigger');
  }

  Future<void> getData() async {
    // get data from user_proivder
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      point = prefs.getInt('point') ?? 0;
      level = prefs.getString('level') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightModeBgColor,
        body: ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: const HomeScreenBody(),
        ));
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  Future<void> refreshHome(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.clearMyNutrition();
    userProvider.clearMyMission();
    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ConnectionProvider, UserProvider>(
        builder: (context, connectionProv, userProvider, child) {
      if (connectionProv.internetConnected == false) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Tidak Ada Koneksi Internet"),
              ElevatedButton(
                onPressed: () => refreshHome(context),
                child: const Text("Refresh"),
              )
            ],
          ),
        );
      }

      return SafeArea(
          child: RefreshIndicator(
        onRefresh: () => refreshHome(context),
        child: Column(
          children: [
            MainTopBar(),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                DateSelector(
                  userProvider: userProvider,
                ),
                const SizedBox(
                  height: 16,
                ),
                const UserNutrion(),
                const MyMisssion()
              ],
            ))
          ],
        ),
      ));
    });
  }
}

// class _MainTopBar extends StatelessWidget {
//   const _MainTopBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProvider>(builder: (context, userProvider, _) {
//       if (userProvider.user == null && !userProvider.onSearch) {
//         userProvider.getUserData(

//         );

//         return const LoadingSingleBox();
//       }
//       if (userProvider.user == null && userProvider.onSearch) {
//         // if the categories are being searched, show a skeleton loading
//         return const LoadingSingleBox();
//       }
//       return const MainTopBar();
//     });
//   }
// }

class UserNutrion extends StatelessWidget {
  const UserNutrion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.myNutrition == null && !userProvider.onSearch) {
        userProvider.getNutrion();

        return const LoadingSingleBox();
      }
      if (userProvider.myNutrition == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return const LoadingSingleBox();
      }
      if (userProvider.myNutrition == null) {
        // if the categories have been loaded, show the category chips
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Tidak ada produk yang ditemukan'),
          ),
        );
      }

      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Kalori tersisa",
                  style: normalText.copyWith(
                      fontSize: 14, color: const Color(0xff454545))),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(userProvider.myNutrition?.calorieLeft.toString() ?? "0",
                      style: normalText.copyWith(
                          fontSize: 37, fontWeight: FontWeight.w600)),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("kcal", style: normalText.copyWith(fontSize: 14)),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          NutritionalBar(
            carbsPercent:
                userProvider.myNutrition?.carbPercentage.toDouble() ?? 0,
            fatPercent: userProvider.myNutrition?.fatPercentage.toDouble() ?? 0,
            proteinPercent:
                userProvider.myNutrition?.proteinPercentage.toDouble() ?? 0,
          ),
          const SizedBox(
            height: 16,
          ),
          NutritionInfoBox(
            carbs: userProvider.myNutrition?.carbohydrate ?? 0,
            protein: userProvider.myNutrition?.protein ?? 0,
            fat: userProvider.myNutrition?.fat ?? 0,
          ),
          const SizedBox(
            height: 16,
          ),
          CaloriRow(
              target: userProvider.myNutrition?.targetCalories ?? 0,
              asupan: userProvider.myNutrition?.intakeCalories ?? 0,
              aktivitas: userProvider.myNutrition?.activityCalories ?? 0,
              kaloriTersedia: userProvider.myNutrition?.calorieLeft ?? 0),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    });
  }
}

class MyMisssion extends StatelessWidget {
  const MyMisssion({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.myMission == null && !userProvider.onSearch) {
        userProvider.getMyMission();

        return const LoadingSingleBox();
      }
      if (userProvider.myMission == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return const LoadingSingleBox();
      }
      if (userProvider.myMission == null) {
        // if the categories have been loaded, show the category chips
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Tidak ada produk yang ditemukan'),
          ),
        );
      }

      return Mission(myMission: userProvider.myMission);
    });
  }
}
