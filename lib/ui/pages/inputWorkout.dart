import 'package:flutter/material.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';

class InputWorkoutScreen extends StatefulWidget {
  const InputWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<InputWorkoutScreen> createState() => _InputWorkoutScreenState();
}

class _InputWorkoutScreenState extends State<InputWorkoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Kegiatan Latihan',
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
