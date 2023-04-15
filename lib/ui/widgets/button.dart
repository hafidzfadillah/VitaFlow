import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Color background;
  final Function()? onClick;

  const RoundedButton({super.key, required this.title, required this.style, required this.background, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onClick,
        child: Text(
          title,
          style: style,
        ),
        style: ElevatedButton.styleFrom(
            primary: background,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
      ),
    );
  }
}
