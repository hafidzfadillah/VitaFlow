import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class SkeletonLoadingChipList extends StatelessWidget {
  const SkeletonLoadingChipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        duration: Duration(seconds: 3), //Default value
        interval: Duration(seconds: 5), //Default value: Duration(seconds: 0)
        color: Colors.grey, //Default value
        colorOpacity: 1, //Default value
        enabled: true, //Default value
        direction: ShimmerDirection.fromLTRB(), //Default Value
        child: Container(
          color: Colors.grey[300]
        ));
  }
}
