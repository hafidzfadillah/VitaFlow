import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/HomeScreen.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/DrinkProgressBar.dart';
import 'package:vitaflow/ui/widgets/HistoryCard.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:page_transition/page_transition.dart';

class RecordWaterScreen extends StatefulWidget {
  const RecordWaterScreen({Key? key}) : super(key: key);

  @override
  State<RecordWaterScreen> createState() => _RecordWaterScreenState();
}

class _RecordWaterScreenState extends State<RecordWaterScreen> {
    bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      appBar: CustomAppBar(
        title: 'Asupan Minum',
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onClick: () {
          Navigator.pop(context);
        }),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 33),
                children: [
                  Center(
                    child: DrinkProgressBar(
                      currentDrink: 2,
                      goalDrink: 8,
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "History Asupan Minum",
                    style: normalText.copyWith(
                        fontSize: 16,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  HistoryCard(
                    title: 'Catat Asup Minum',
                    date: "Senin, 12 Juli 2021",
                    value: 2,
                    unit: 'Gelas',
                    withTarget: true,
                    target: 8,
                  ), 
                  
                
                ],
                
              ),
            ),
             Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
               child: SwipeableButtonView(
                
                buttonText: 'Catat Asup Minum',
                buttonWidget: Container(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                  ),
                ),
                activeColor: primaryColor,
                isFinished: isFinished,
                onWaitingProcess: () {
                  Future.delayed(Duration(seconds: 2), () {
                    setState(() {
                      isFinished = true;
                    });
                  });
                },
                onFinish: () async {
                  await Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: HomeScreen()));
             
                  //TODO: For reverse ripple effect animation
                  setState(() {
                    isFinished = false;
                  });
                },
                         ),
             ),
          ],
        ),
      ),

      
      
      
    );
  }
}
