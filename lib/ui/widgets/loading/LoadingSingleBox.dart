import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class LoadingSingleBox extends StatelessWidget {
  final double height;
  const LoadingSingleBox({
    Key? key,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
          color: Color(0xff9098B1).withOpacity(0.3),
          borderRadius: BorderRadius.circular(defMargin)),
    
    );
  }
}

class LoadingSingleBoxCircular extends StatelessWidget {
  final double height;
  const LoadingSingleBoxCircular({
    Key? key,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xff9098B1).withOpacity(0.3),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class LoadingArticle extends StatelessWidget {
  final double height;
  const LoadingArticle({
    Key? key,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100.0,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff9098B1).withOpacity(0.3),
              borderRadius: BorderRadius.circular(defMargin),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: Color(0xff9098B1).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(defMargin),
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: Color(0xff9098B1).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(defMargin),
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: 80.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: Color(0xff9098B1).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(defMargin),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


  