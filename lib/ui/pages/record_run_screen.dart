import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';

import '../../core/viewmodels/connection/connection.dart';
import '../widgets/button.dart';
import '../widgets/history_step_card.dart';

class RecordRunScreen extends StatefulWidget {
  const RecordRunScreen({Key? key}) : super(key: key);

  @override
  State<RecordRunScreen> createState() => _RecordRunScreenState();
}

class _RecordRunScreenState extends State<RecordRunScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/record-add-step');
          if (result == true) {
            Navigator.pop(context);
          }
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: CustomAppBar(
        title: 'Record Aktifitasi Lari',
        backgroundColor: lightModeBgColor,
        elevation: 0,
        leading: CustomBackButton(onClick: () {
          Navigator.pop(context);
        }),
      ),
      body: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: RecordRunBody(),
      ),
    );
  }
}

class RecordRunBody extends StatelessWidget {
  const RecordRunBody({Key? key}) : super(key: key);

  Future<void> refreshHome(BuildContext context) async {
    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ConnectionProvider, UserProvider>(
      builder: (context, conProv, userProv, child) {
        if (conProv.internetConnected == false) {
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
            child: ListView(
          padding: EdgeInsets.all(defMargin),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Progress aktifitasi lari saat ini",
                    style: normalText.copyWith(
                        fontSize: 14, color: const Color(0xff454545))),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        (userProv.userStep == null ||
                                userProv.userStep?.isEmpty == true)
                            ? "0"
                            : userProv.userStep?.last.value.toString() ??
                                "0", // mengambil data terakhir dari userProv.userStep
                        style: normalText.copyWith(
                            fontSize: 37, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(" langkah", style: normalText.copyWith(fontSize: 14)),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            _UserStepHistory()
          ],
        ));
      },
    );
  }
}

class _UserStepHistory extends StatelessWidget {
  const _UserStepHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProv, _) {
      if (userProv.userStep == null && !userProv.onSearch) {
        print("get step data");
        userProv.getUserStepHistory();
        return const Center(child: CircularProgressIndicator());
      }

      if (userProv.userStep == null && userProv.onSearch) {
        return const Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "History lari",
              style: normalText.copyWith(
                  fontSize: 16,
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userProv.userStep!.length,
              itemBuilder: (context, index) {
                return HistoryStepCard(
                  unit: " langkah",
                  withTarget: false,
                  title: "Catatan langkah",
                  value: userProv.userStep?[index].value ?? 0,
                  date: userProv.userStep?[index].date.toString() ?? "",
                );
              },
            )
          ],
        ),
      );
    });
  }
}
