import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class FoodRating extends StatelessWidget {
  const FoodRating({Key? key , required this.rating}) : super(key: key);

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19, vertical: 30),
      decoration: BoxDecoration(
        color:  rating  == 'A' ?  Color(0xffCFEEE3) : rating == 'B' ?  Color(0xffFDF3D1) : Color(0xffFADAD2),
        borderRadius: BorderRadius.circular(34),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(children: [
              Text(
                  rating  == 'A' ?  "😄"  : rating == 'B'  ? "😀" : "🤨",
                style: TextStyle(fontSize: 33),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Food Rating",
                    style: normalText.copyWith(
                        fontSize: 14,
                        color: Color(0xff040404),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Very Good",
                    style: normalText.copyWith(
                        fontSize: 12,
                        color: Color(0xff617D79),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ]),
          ),
          Text(
            rating,
            style: normalText.copyWith(
                fontSize: 33,
                color: rating  == 'A' ?  Color(0xff18B279) : rating == 'B' ?  Color(0xffFFCB20) : Color(0xffEF4F28),
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
