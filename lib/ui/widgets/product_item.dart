import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/core/models/product/product_model.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:vitaflow/ui/widgets/product_price.dart';

class ProductItem extends StatelessWidget {

  const ProductItem({Key? key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: defMargin , vertical: 10),
          decoration: BoxDecoration(
              color: Color(0xffF6F8FA),
              borderRadius: BorderRadius.circular(defMargin)),
          padding: EdgeInsets.all(defRadius),
          child: Stack(
            children: [
              Row(
                children: [
                  Flexible(
                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            
                           'https://freshmart.oss-ap-southeast-5.aliyuncs.com/images/images/${product.image}'
                           , fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.category,
                            style: subtitleTextStyle2,
                          ),
                          Text(
                            product.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: subheaderSize),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: subtitleTextStyle2,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                               ProductPrice(price: double.parse(product.price)),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Beli',
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24))),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              )
            ],
          )),
    );
  }
}
