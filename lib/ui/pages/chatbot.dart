import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:vitaflow/ui/widgets/chat_bubble.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral20,
      appBar:   CustomAppBar(
        title: 'Coach Ai',
        backgroundColor: lightModeBgColor,
        elevation: 0,
        leading: CustomBackButton(onClick: () {
          Navigator.pop(context);
        }),
      ),
      body: SafeArea(
        child: Column(
          children: [
           
            Expanded(
                child: Container(
              color: Color(0xFFF9F9F9),
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (c, i) {
                    return CustomChatBubble(
                        text:
                            'Text message lorem ipsum dolor sit amet ipsum dolor sit amet message ${i + 1}',
                        date: '9:14 PM',
                        background: i % 2 == 0 ? neutral30 : primaryLightColor,
                        isSender: i % 2 != 0);
                  }),
            )),
            MessageBar(
              messageBarColor: Colors.white,
              sendButtonColor: primaryColor,
              onSend: ((p0) {
                if (p0.isNotEmpty) {
                  Fluttertoast.showToast(msg: 'send: $p0');
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
