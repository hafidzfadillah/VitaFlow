import 'package:flutter/material.dart';

class LoadingTypeHorizontal extends StatelessWidget {
  final int length;
  const LoadingTypeHorizontal({
    Key? key,
    this.length = 7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            length,
            (i) => Container(
              width: 100,
              height: 30,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: const Color(0xff9098B1).withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
