import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/theme.dart';

class WorkoutItem extends StatefulWidget {
  final String title;
  final int durasiDetik, jmlKkal;
  bool? isChecked = false;
  final ValueChanged<bool> onSelect;

  WorkoutItem(
      {super.key,
      required this.title,
      required this.durasiDetik,
      required this.jmlKkal,
          required this.onSelect,

      this.isChecked = false});

  @override
  State<WorkoutItem> createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: '${widget.durasiDetik ~/ 60} menit',
                  style: GoogleFonts.poppins(
                      color: primaryColor, fontSize: captionSize),
                ),
                TextSpan(
                  text: ' - ${widget.jmlKkal} kkal',
                  style: GoogleFonts.poppins(
                      color: Colors.grey, fontSize: captionSize),
                )
              ]))
            ],
          )),
          Checkbox(
              value: widget.isChecked,
              onChanged: (bool? newValue) {
                if (newValue != null) {
                  widget.onSelect(newValue);
                }
              })
        ],
      ),
    );
  }
}
