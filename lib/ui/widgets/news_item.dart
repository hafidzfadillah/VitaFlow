import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/core/models/article/article_model.dart';
import 'package:vitaflow/ui/home/theme.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({Key? key , required this.article}) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(defRadius),
              child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                      'https://freshmart.oss-ap-southeast-5.aliyuncs.com/images/images/${article.image}',
                    fit: BoxFit.cover
                  )),
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tips',
                    style: GoogleFonts.poppins(color: Color(0xff85868A)),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    article.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: subheaderSize),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    ' ${article.readingTime} menit baca',
                    style: GoogleFonts.poppins(color: neutral60),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
