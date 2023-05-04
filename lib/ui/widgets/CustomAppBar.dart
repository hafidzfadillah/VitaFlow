import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitaflow/ui/home/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      elevation: elevation ?? 0,
      leading: leading,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: blackColor,
            fontSize: subheaderSize),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
