import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/viewmodels/chat/chat_provider.dart';
import 'package:vitaflow/core/viewmodels/connection/connection.dart';
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
        appBar: CustomAppBar(
          title: 'Coach Ai',
          backgroundColor: lightModeBgColor,
          elevation: 0,
          leading: CustomBackButton(onClick: () {
            Navigator.pop(context);
          }),
        ),
        body: ChangeNotifierProvider(
          create: (context) => ChatProvider(),
          child: ChatBotBody(),
        ));
  }
}

class ChatBotBody extends StatefulWidget {
  const ChatBotBody({
    super.key,
  });

  @override
  State<ChatBotBody> createState() => _ChatBotBodyState();
}

class _ChatBotBodyState extends State<ChatBotBody> {
  TextEditingController messageController = TextEditingController(text: "");
  Future<void> refreshHome(BuildContext context) async {
    final chatProv = Provider.of<ChatProvider>(context, listen: false);
    chatProv.sendMessage( "Tes" );
    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ConnectionProvider, ChatProvider>(
        builder: (context, connectionProv, chatProv, _) {
          print(chatProv.messages);
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

      if (chatProv.messages?.length == 0) {
        return SafeArea(
        child: Column(
          children: [

            Expanded(
                child: Container(
              color: Color(0xFFF9F9F9),
              
              child: ListView(
                children: [
                  CustomChatBubble(
                    text: "Halo saya adalah Vita Bot, apa yang bisa saya bantu?", 
                    date: '',
                    background: neutral30,
                    isSender: false

                  ),
                  CustomChatBubble(
                    text: "Yuk coba dengan pertanyaan contoh berikut", 
                    date: '',
                    background: neutral30,
                    isSender: false

                  ),

                  Padding(
                    padding :  EdgeInsets.symmetric( horizontal: 16, vertical: 8),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            chatProv.sendMessage("Bagaimana gerakan push up yang benar ?");
                          
                             
                          
                          },
                          
                          child: Container(
                            margin:  EdgeInsets.only(bottom: 12),
                        
                            padding:  EdgeInsets.symmetric( horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border:  Border.all(color: primaryColor, width: 1) ,
                            borderRadius: BorderRadius.circular(8)),
                          child: Text("Bagaimana gerakan push up yang benar ?", style: normalText.copyWith(fontSize: 16, color: primaryColor),),
                                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            chatProv.sendMessage("makanan yang bagus saat diet ?");
                          
                             
                          
                          },
                          child: Container(
                            
                                      margin: EdgeInsets.only(bottom: 12),
                        
                            padding:  EdgeInsets.symmetric( horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border:  Border.all(color: primaryColor, width: 1) ,
                            borderRadius: BorderRadius.circular(8)),
                          child: Text("Makanan yang bagus saat diet", style: normalText.copyWith(fontSize: 16, color: primaryColor),),
                                          ),
                        ),
                      ],
                    ))
                ],
              )
            )),

            

            MessageBar(
                messageBarColor: Colors.white,
              sendButtonColor: primaryColor,
              
              onSend: ((p0) {
                if (p0.isNotEmpty) {
                  chatProv
                      .sendMessage(p0);
                  messageController.clear();
                }
              }),

            ),


          ],
        ),
        );
      }


      

     
      return SafeArea(
        child: Column(
          children: [

            Expanded(
                child: Container(
              color: Color(0xFFF9F9F9),
              
              child: ListView.builder(
                  itemCount: chatProv.messages?.length ?? 0,
                  itemBuilder: (c, i) {
                    return CustomChatBubble(
                        text: chatProv.messages?[i].message ?? '',
                        date: '',
                        background: i % 2 == 0 ? neutral30 : primaryLightColor,
                        isSender:  chatProv.messages?[i].role   == 'user' ? true : false );
                  }),
            )),

            

            MessageBar(
                messageBarColor: Colors.white,
              sendButtonColor: primaryColor,
              onSend: ((p0) {
                if (p0.isNotEmpty) {
                  chatProv
                      .sendMessage(p0);
                  messageController.clear();
                }
              }),

            ),
            
           
          ],
        ),
      );
    });
  }
}
