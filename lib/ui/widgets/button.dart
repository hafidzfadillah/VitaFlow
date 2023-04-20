import 'package:flutter/material.dart';

import '../home/theme.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Color background;
  final Function()? onClick;
  final double width;

  RoundedButton({
    super.key,
    required this.title,
    required this.style,
    required this.background,
    required this.onClick,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
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

class RoundedOutlineButton extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Color color;
  final Function()? onClick;
  final double width;

  RoundedOutlineButton({
    super.key,
    required this.title,
    required this.style,
    required this.color,
    required this.onClick,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48,
      child: ElevatedButton(
        onPressed: onClick,
        child: Text(
          title,
          style: style,
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(color: color, width: 2))),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  final Function() onClick;
  final Color? iconColor;

  const CustomBackButton({super.key, required this.onClick, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: CircleBorder(),
      color: Colors.transparent,
      child: InkWell(
          onTap: onClick,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.arrow_back,
              color: iconColor == null ? primaryColor : iconColor,
            ),
          )),
    );
  }
}

class NotifButton extends StatelessWidget {
  final bool hasUnreadNotifications;
  final void Function() onClick;

  NotifButton({required this.hasUnreadNotifications, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: onClick, icon: Icon(Icons.notifications_outlined)),
        if (hasUnreadNotifications)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  '!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
