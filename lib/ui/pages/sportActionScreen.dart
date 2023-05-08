import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomLinearProgress.dart';
import 'package:vitaflow/ui/widgets/button.dart';

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
          Expanded(
              child: Image.asset(
            widget.data[currentIdx]['img'],
            fit: BoxFit.cover,
            // width: double.infinity,
            // height: double.infinity,
          )),
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
          Row(
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
                          Navigator.pop(context);
                          print('workout done');
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
          )
        ],
      )),
    );
  }
}
