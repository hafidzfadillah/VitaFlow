import 'package:flutter/material.dart';

class NutritionalBar extends StatefulWidget {
  final double carbsPercent;
  final double fatPercent;
  final double proteinPercent;

  const NutritionalBar({
    Key? key,
    required this.carbsPercent,
    required this.fatPercent,
    required this.proteinPercent,
  }) : super(key: key);

  @override
  _NutritionalBarState createState() => _NutritionalBarState();
}

class _NutritionalBarState extends State<NutritionalBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _carbsAnimation;
  late Animation<double> _fatAnimation;
  late Animation<double> _proteinAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _carbsAnimation = Tween<double>(
      begin: 0,
      end: widget.carbsPercent,
    ).animate(_controller);
    _fatAnimation = Tween<double>(
      begin: 0,
      end: widget.fatPercent,
    ).animate(_controller);
    _proteinAnimation = Tween<double>(
      begin: 0,
      end: widget.proteinPercent,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(NutritionalBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.carbsPercent != widget.carbsPercent ||
        oldWidget.fatPercent != widget.fatPercent ||
        oldWidget.proteinPercent != widget.proteinPercent) {
      _controller.reset();
      _carbsAnimation = Tween<double>(
        begin: oldWidget.carbsPercent,
        end: widget.carbsPercent,
      ).animate(_controller);
      _fatAnimation = Tween<double>(
        begin: oldWidget.fatPercent,
        end: widget.fatPercent,
      ).animate(_controller);
      _proteinAnimation = Tween<double>(
        begin: oldWidget.proteinPercent,
        end: widget.proteinPercent,
      ).animate(_controller);
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          height: 32,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffF6F8FA),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              _buildNutrientBar(
                color: Color(0xff0BB576),
                widthFactor: _carbsAnimation.value,
                radius: 8.0,
                totalWidth: totalWidth,
              ),
              _buildNutrientBar(
                color: Color(0xffF39CFF),
                widthFactor: _fatAnimation.value,
                leftOffset: totalWidth * _carbsAnimation.value,
                totalWidth: totalWidth,
              ),
              _buildNutrientBar(
                color: Color(0xffFFDD60),
                widthFactor: _proteinAnimation.value,
                leftOffset:
                    totalWidth * (_carbsAnimation.value + _fatAnimation.value),
                totalWidth: totalWidth,
              ),
            ],
          ),
        );
      },
    );
  }
    Widget _buildNutrientBar({
      required Color color,
      required double widthFactor,
      double leftOffset = 0.0,
      double radius: 0,
      required double totalWidth,
    }) {
      return Positioned(
        left: leftOffset,
        child: Container(
          height: 32,
          width: totalWidth * widthFactor,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(leftOffset == 0 ? radius : 0),
              bottomLeft: Radius.circular(leftOffset == 0 ? radius : 0),
              topRight: Radius.circular(
                  leftOffset == totalWidth * (widget.carbsPercent + widget.fatPercent)
                      ? radius
                      : 0),
              bottomRight: Radius.circular(
                  leftOffset == totalWidth * (widget.carbsPercent + widget.fatPercent)
                      ? radius
                      : 0),
            ),
          ),
        ),
      );
    }
  }
  

