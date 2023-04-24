import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class MyCountdown extends StatefulWidget {
  final int duration;
  final Function onCountdownEnd;
  final AnimationController controller;

  MyCountdown(
      {required this.duration,
      required this.onCountdownEnd,
      required this.controller});

  @override
  _MyCountdownState createState() => _MyCountdownState();
}

class _MyCountdownState extends State<MyCountdown>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..addListener(() {
        setState(() {});
      });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onCountdownEnd();
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
    return LinearProgressIndicator(
      value: _controller.value,
      minHeight: 8,
      backgroundColor: Colors.grey,
      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
    );
  }
}
