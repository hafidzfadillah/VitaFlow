import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/core/models/exercise/exercise_model.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/main_pages.dart';
import 'package:vitaflow/ui/widgets/CustomLinearProgress.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:video_player/video_player.dart';

import '../widgets/video_player.dart';

class SportActionScreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const SportActionScreen({super.key, required this.data});

  @override
  State<SportActionScreen> createState() => _SportActionScreenState();
}

class _SportActionScreenState extends State<SportActionScreen>
    with TickerProviderStateMixin {
  int currentIdx = 0;
  bool isFinished = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    setCountDown();
  }

  void setCountDown() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.data[currentIdx]['durasi']),
    )..addListener(() {
        setState(() {});
      });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFinished = true;
        });
      }
    });
    // _controller.reverse(
    // from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _controller.forward(
        from: _controller.value == 0.0 ? _controller.value : 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 40.h,
            child: VideoPlayerView(
                url: widget.data[currentIdx]['video'],
                dataSourceType: DataSourceType.network),
          ),
          LinearProgressIndicator(
            value: _controller.value,
            minHeight: 8,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.data[currentIdx]['title'],
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: headerSize),
              ),
              Text("x${widget.data[currentIdx]['set']}",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 40)),
              // RoundedButton(
              //     title: currentIdx == widget.data.length - 1
              //         ? 'Selesai'
              //         : 'Selanjutnya',
              //     style: GoogleFonts.poppins(color: Colors.white),
              //     background: isFinished ? primaryColor : Colors.grey,
              //     onClick: () {
              //       if (isFinished) {
              //         print('next');
              //       }
              //     },
              //     width: 90.w)
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                    child: Visibility(
                  visible: currentIdx == 0 ? false : true,
                  child: InkWell(
                    onTap: () {
                      if (isFinished) {
                        setState(() {
                          currentIdx -= 1;
                          isFinished = false;
                        });

                        setCountDown();
                      }
                    },
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.skip_previous_outlined,
                          color: Colors.grey,
                        ),
                        Text(
                          'Sebelumnya',
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ],
                    )),
                  ),
                )),
                Expanded(
                  child: RoundedButton(
                      title: currentIdx == widget.data.length - 1
                          ? 'Selesai'
                          : 'Selanjutnya',
                      style: GoogleFonts.poppins(color: Colors.white),
                      background: isFinished ? primaryColor : Colors.grey,
                      onClick: () {
                        if (isFinished) {
                          if (currentIdx == widget.data.length - 1) {
                            UserProvider userProvider = UserProvider();
                            userProvider.storeExercise([
                              ExerciseModel(id: 2, exerciseDuration:  60 , caloriesBurnedEstimate:  10 , exerciseName:  'Warm up 1', createdAt: DateTime.now() , updatedAt: DateTime.now(), exerciseDescription: '', exerciseRepetition: 1, exerciseVideoUrl: '' ,   ), 
                              ExerciseModel(id: 3, exerciseDuration: 60 , caloriesBurnedEstimate:  10 , exerciseName:  'Warm up 1', createdAt: DateTime.now() , updatedAt: DateTime.now(), exerciseDescription: '', exerciseRepetition: 1, exerciseVideoUrl: '' ,   ), 
                              ExerciseModel(id: 1, exerciseDuration: 80 , caloriesBurnedEstimate:  10 , exerciseName:  'Warm up 1', createdAt: DateTime.now() , updatedAt: DateTime.now(), exerciseDescription: '', exerciseRepetition: 1, exerciseVideoUrl: '' ,   ), 
                          
                            ]
                               );

                            // snackbar
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'Yeyy kamu berhasil menyelesaikan workout pertamamu'),
                            ));
                               Future.delayed(const Duration(seconds: 1), () {
                              // pop screen
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainPages())).then((value) {
                                if (value != null && value == true) {
                                  // Refresh widget disini
                                }
                              });
                            });
                          } else {
                            setState(() {
                              currentIdx += 1;
                              isFinished = false;
                            });
                            setCountDown();
                          }
                        }
                      },
                      width: double.infinity),
                  //   InkWell(
                  // onTap: () {
                  //   if (currentIdx == widget.data.length - 1) {
                  //     print('workout finished');
                  //   } else {
                  //     setState(() {
                  //       currentIdx += 1;
                  //       isFinished = false;
                  //     });
                  //   }
                  // },
                  // child: Container(
                  //     child: Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Selanjutnya',
                  //       style: GoogleFonts.poppins(
                  //           color: isFinished ? primaryColor : Colors.grey),
                  //     ),
                  //     Icon(
                  //       Icons.skip_next_outlined,
                  //       color: isFinished ? primaryColor : Colors.grey,
                  //     ),
                  //   ],
                  // )),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
