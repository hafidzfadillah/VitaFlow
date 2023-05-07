import 'package:flutter/material.dart';



import 'package:vitaflow/ui/home/theme.dart';
class DrinkProgressBar extends StatefulWidget {
  final int currentDrink;
  final int goalDrink;
  final double width;

  const DrinkProgressBar({
    Key? key,
    required this.currentDrink,
    required this.goalDrink,
    required this.width,
  }) : super(key: key);

  @override
  _DrinkProgressBarState createState() => _DrinkProgressBarState();
}

class _DrinkProgressBarState extends State<DrinkProgressBar>
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
    _animation = Tween<double>(begin: 0, end: widget.currentDrink.toDouble())
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
    double percentage = _animation.value / widget.goalDrink;

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${_animation.value.toInt()} / ${widget.goalDrink} ",
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Gelas",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff333333),
                      ),
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
