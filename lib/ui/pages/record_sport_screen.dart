import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/burned_calori_bar.dart';
import 'package:vitaflow/ui/widgets/exercise_schedule.dart';

import '../../core/viewmodels/connection/connection.dart';
import '../widgets/KaloriProgressBar.dart';
import '../widgets/button.dart';

class RecordSportScreen extends StatefulWidget {
  const RecordSportScreen({Key? key}) : super(key: key);

  @override
  State<RecordSportScreen> createState() => _RecordSportScreenState();
}

class _RecordSportScreenState extends State<RecordSportScreen> {
  //status: 0=lock, 1=available, 2=done
  final List<Map<String, dynamic>> _exercises = [
    {
      "week": 1,
      "days": [
        {
          "day": 1,
          "status": 1,
          "title": "Seluruh tubuh",
          "description":
              "Latihan ini berfokus untuk memaksimalkan seluruh anggota tubuh",
          "exercises": [
            {
              "img": "https://freshmart.oss-ap-southeast-5.aliyuncs.com/images/images/alora-griffiths-WX7FSaiYxK8-unsplash.jpg",
              "title": "Warm up 1 ",
              "durasi": 1,
              "set": 3,
              "status": false,
              "video" : "https://freshmart.oss-ap-southeast-5.aliyuncs.com/videos/pemanasan1.mp4"
            },
            {
              "img": "https://freshmart.oss-ap-southeast-5.aliyuncs.com/images/images/alex-shaw-8Naac6Zpy28-unsplash.jpg",
              "title": "Warm up 2",
              "durasi": 1,
              "set": 2,
              "status": false,
              "video" : "https://freshmart.oss-ap-southeast-5.aliyuncs.com/videos/pemanasan2.mp4"
            },
            {
              "img": "https://freshmart.oss-ap-southeast-5.aliyuncs.com/images/images/bruce-mars-tj27cwu86Wk-unsplash.jpg",
              "title": "Push up",
              "durasi": 1,
              "set": 10,
              "status": false,
                            "video":
                  "https://freshmart.oss-ap-southeast-5.aliyuncs.com/videos/pushup.mp4"

            },
          ],
        },
        {
          "day": 2,
          "status": 0,
          "title": "Seluruh tubuh",
          "description":
              "Latihan ini berfokus untuk memaksimalkan seluruh anggota tubuh",
          "exercises": [
            {
              "img": "assets/images/sport1.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
            {
              "img": "assets/images/sport2.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
          ],
        },
        {
          "day": 3,
          "status": 0,
          "title": "Seluruh tubuh",
          "description":
              "Latihan ini berfokus untuk memaksimalkan seluruh anggota tubuh",
          "exercises": [
            {
              "img": "assets/images/sport1.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
            {
              "img": "assets/images/sport2.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
          ],
        },
        {
          "day": 4,
          "status": 0,
          "title": "Seluruh tubuh",
          "description":
              "Latihan ini berfokus untuk memaksimalkan seluruh anggota tubuh",
          "exercises": [
            {
              "img": "assets/images/sport1.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
            {
              "img": "assets/images/sport2.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
          ],
        },
        {
          "day": 5,
          "status": 0,
          "title": "Seluruh tubuh",
          "description":
              "Latihan ini berfokus untuk memaksimalkan seluruh anggota tubuh",
          "exercises": [
            {
              "img": "assets/images/sport1.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
            {
              "img": "assets/images/sport2.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
          ],
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Aktivitas Olahraga',
        backgroundColor: lightModeBgColor,
        elevation: 0,
        leading: CustomBackButton(onClick: () {
          Navigator.pop(context);
        }),
      ),
      backgroundColor: lightModeBgColor,
      body: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: RecordSportBody(exercises: _exercises)),
    );
  }
}

class RecordSportBody extends StatelessWidget {
  const RecordSportBody({
    super.key,
    required List<Map<String, dynamic>> exercises,
  }) : _exercises = exercises;
  

  final List<Map<String, dynamic>> _exercises;
Future<void> refreshHome(BuildContext context) async {
 
    ConnectionProvider.instance(context).setConnection(true);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<ConnectionProvider,UserProvider>(
      builder: (context, connectionProv,userProv, _) {
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

           if (userProv.myNutrition == null && !userProv.onSearch) {
          userProv.getNutrion();
          userProv.getUserData();

          return Center(child: const CircularProgressIndicator());
        }
        if (userProv.myNutrition == null && userProv.onSearch) {
          // if the categories are being searched, show a skeleton loading
          return Center(child: const CircularProgressIndicator());
        }

         return SafeArea(
        child: Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(defMargin),
            children: [
              Center(child: BurnCaloriBar(value: userProv.myNutrition?.activityCalories ?? 0, width: 200)),
              SizedBox(
                height: 6.h,
              ),
              const Center(
                child: Text(
                  "Target: 300 kalori",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff333333),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              const Text(
                "Exercise Plan",
                style: TextStyle(
                  fontSize: headerSize,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff333333),
                ),
              ),
              ExerciseSchedule(exercises: _exercises , isPremium:  userProv.user?.isPremium ?? 0 ,) ,

              SizedBox(
                height: 8.h,
              ),
              Text("History Exercise", style: TextStyle(
                  fontSize: headerSize,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff333333),
                ),),

              SizedBox(
                height: 8.h,
              ),

            ],
          ),
        )
      ],
    ));
      },
    );
 
   
  }
}
