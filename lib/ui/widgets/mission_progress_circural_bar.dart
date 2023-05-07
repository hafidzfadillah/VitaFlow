import 'package:flutter/material.dart';


class MissionProgressCircuralBar extends StatelessWidget {
  final IconData icon;
  final double progress;
  final double size;
  final Color backgroundColor;
  final Color foregroundColor;
  final double strokeWidth;
    final String assetName;
 

  const MissionProgressCircuralBar({
    Key? key,
     this.icon = Icons.check, 
    required this.progress,
    this.size = 80.0,
    this.backgroundColor = Colors.grey,
    this.foregroundColor = Colors.blue,
    this.strokeWidth = 10.0,
    required this.assetName,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final double radius = (size - strokeWidth) / 2;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          SizedBox(
            width: 60,
          height: 60,
            child: CircularProgressIndicator(
            value: progress,
            backgroundColor: backgroundColor,
            color: foregroundColor,
            strokeWidth: strokeWidth,
            
          ),

          ),
          
          Center(
            child: progress != 100
                ? Image.network(assetName,
                width: 24, 
                height: 24,

         
                  )
                : Icon(
                    icon,
                    color: foregroundColor,
                    size: radius,
                    
                  ),
          ),
        ],
      ),
    );
  }
}
