import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/button.dart';

import '../../core/viewmodels/connection/connection.dart';
import '../../core/viewmodels/user/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    UserProvider userProvider = UserProvider();
    userProvider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      appBar: AppBar(
        backgroundColor: lightModeBgColor,
        elevation: 0,
        leading: IconButton(
          color: Color(0xff33333),
          icon: Icon(Icons.close, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ChangeNotifierProvider(
          create: (context) => UserProvider(), child: ProfileBody()),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> refreshHome(BuildContext context) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      userProvider.clearUserData();
      ConnectionProvider.instance(context).setConnection(true);
    }

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

      if (userProvider.user == null && !userProvider.onSearch) {
        userProvider.getUserData();

        return const CircularProgressIndicator();
      }
      if (userProvider.user == null && userProvider.onSearch) {
        // if the categories are being searched, show a skeleton loading
        return const CircularProgressIndicator();
      }
      String name = userProvider.user?.name ?? ""; // mengambil nama pengguna
      String initial = name.toUpperCase().substring(0, 1);
      return SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Menu utama",
                  style: headerTextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Center(
                          child: Text(
                              userProvider.user?.name.substring(0, 1) ?? "",
                              style: normalText.copyWith(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ))),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xffFFCA22),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(initial + name.substring(1),
                            textAlign: TextAlign.center,
                            style: headerTextStyle.copyWith(
                                fontSize: 21, fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 5,
                        ), 
                      
                        

                        Row(
                          children: [
                            Icon(
                    Icons.star,
                    color: Colors.yellow[700],
                  ),
                              Text(
                              userProvider.user?.point.toString() ?? "0",
                              style: headerTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.yellow[700]),
                            ),
                            SizedBox( width:  5,),
                            Text("-"),
                            SizedBox( width:  5,),
                            Text(
                              userProvider.user?.isPremium == 1
                                  ? "premium"
                                  : "Regular",
                              style: headerTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: userProvider.user?.isPremium == 1
                                      ? Colors.yellow[700]
                                      : Colors.grey[600]),
                            ),
                          ],
                        )
                      
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("",
                    textAlign: TextAlign.center,
                    style: subtitleTextStyle.copyWith(
                      fontSize: 14,
                    )),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Account",
              style: headerTextStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text("Edit Profile",
                            style: headerTextStyle.copyWith(fontSize: 15))),
                    Icon(Icons.arrow_right_rounded, size: 30),
                  ],
                ),
                SizedBox(height: 5),
               
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text("Help",
                            style: headerTextStyle.copyWith(fontSize: 15))),
                    Icon(Icons.arrow_right_rounded, size: 30),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "General",
              style: headerTextStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text("Privacy and policy",
                            style: headerTextStyle.copyWith(fontSize: 15))),
                    Icon(Icons.arrow_right_rounded, size: 30),
                  ],
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences localStorage =
                        await SharedPreferences.getInstance();

                    // AddressProvider.instance(context).clearAddress();
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                    await preferences.clear();

                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("Keluar",
                              style: headerTextStyle.copyWith(fontSize: 15))),
                      Icon(Icons.arrow_right_rounded, size: 30),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
