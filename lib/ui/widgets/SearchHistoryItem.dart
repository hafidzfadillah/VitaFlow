import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class SearchHistoryItem extends StatelessWidget {
  const SearchHistoryItem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            Icons.history,
            color: Color(0xffB8B8B8),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
           title,
            style: normalText.copyWith(
              fontSize: 14,
              color: Color(0xff333333),
            ),
          ),
        ],
      ),
    );
  }
}
