import 'package:flutter/material.dart';

import 'package:vitaflow/ui/home/theme.dart';

class BurnCaloriBar extends StatefulWidget {
  final int value;
  final double width;

  const BurnCaloriBar({
    Key? key,
    required this.value,
    required this.width,
  }) : super(key: key);

  @override
  _BurnCaloriBar createState() => _BurnCaloriBar();
}

class _BurnCaloriBar extends State<BurnCaloriBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Initialize animation
    _animation = Tween<double>(begin: 0, end: widget.value.toDouble())
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double percentage = _animation.value / 300;

    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
          width: widget.width,
          height: widget.width,
          child: Stack(
            children: [
              SizedBox(
                width: widget.width,
                height: widget.width,
                child: CircularProgressIndicator(
                  value: percentage,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment:  CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${_animation.value.toInt()}  ",
                      textAlign:  TextAlign.center,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,

                        color: Color(0xff333333),
                      )),
                      SizedBox(height: 5,),
                      Text("Calori Burned" , style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff333333),) 
                    ),
                   
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
