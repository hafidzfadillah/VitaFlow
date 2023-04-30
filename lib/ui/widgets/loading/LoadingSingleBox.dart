import 'package:flutter/material.dart';

class LoadingSingleBox extends StatelessWidget {
  final double height;
  const LoadingSingleBox({
    Key? key,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      color: Color(0xff9098B1).withOpacity(0.3),
    );
  }
}

class LoadingSingleBoxCircular extends StatelessWidget {
  final double height;
  const LoadingSingleBoxCircular({
    Key? key,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xff9098B1).withOpacity(0.3),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
