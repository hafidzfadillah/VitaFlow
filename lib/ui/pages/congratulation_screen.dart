import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key});

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: lightModeBgColor,
      body: Center(child: Text("Selamat misi selesai!")),
    );
  }
}
