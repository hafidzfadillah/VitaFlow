import 'package:flutter/material.dart';

import '../home/theme.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Color background;
  final Function()? onClick;

  const RoundedButton(
      {super.key,
      required this.title,
      required this.style,
      required this.background,
      required this.onClick});

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

class CustomBackButton extends StatelessWidget {
  final Function() onClick;

  const CustomBackButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: CircleBorder(),
      child: InkWell(
          onTap: onClick,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.arrow_back,
              color: primaryColor,
            ),
          )),
    );
  }
}
