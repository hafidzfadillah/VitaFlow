import 'package:flutter/material.dart';
import 'package:vitaflow/core/models/foods/food_lite.dart';
import 'package:vitaflow/ui/home/theme.dart';

class FoodItem extends StatefulWidget {
  const FoodItem({
    Key? key,
    required this.title,
    required this.unit,
    required this.cal,
    required this.size,


  }) : super(key: key);

  final String title;
  final String unit;
  final int cal;
  final int size;


  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  bool isChecked = false; // tambahkan variabel boolean

  void onSelect(bool newValue) => setState(() {
        if (newValue == true) {
          isChecked = true;
        } else {
          isChecked = false;
        }

        // gunakan fungsi setState untuk mengubah nilai variabel isChecked
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/food-detail');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: normalText.copyWith(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.size}  ${widget.unit} ',
                          style: normalText.copyWith(
                            fontSize: 13,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          " ${widget.cal} Kalori",
                          style: normalText.copyWith(
                            fontSize: 13,
                            color: Color(0xffB4B8BB),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                // checkbox
                Checkbox(
                  value:
                      isChecked, // gunakan variabel isChecked sebagai nilai checkbox
                  onChanged: (value) => {
                    onSelect(value!)
                  }, // gunakan fungsi toggleChecked sebagai event onChanged
                ),
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
