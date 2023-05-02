import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Record Makanan',
        backgroundColor: lightModeBgColor,
        elevation: 0,
        leading: CustomBackButton(onClick: () {
          Navigator.pop(context);
        }),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            // delete token 
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.pushNamed(context, '/login');

            


          },
          child: Text('logout'),
        ),
      ),
    );
  }
}
