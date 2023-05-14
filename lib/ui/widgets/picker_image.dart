import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitaflow/ui/home/theme.dart';

import 'modal_buttom_sheet.dart';


enum PickType {
  Camera,
  Gallery,
}

class PickerImage {
  static Future<File> pickImage(PickType type) async {
    var file = await ImagePicker().pickImage(
        source:
            type == PickType.Camera ? ImageSource.camera : ImageSource.gallery);

    return File(file!.path);
  }

  /// Function to pick image from
  /// gallery or camera
  static pick(BuildContext context, Function(File) callback) {
    ModalBottomSheet.show(
      title: "Cari makanan dengan gambar",
      
      context: context,
      radiusCircle: 40,
      children: [
        SizedBox(height: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pickWidget(
                iconPath: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                title: "Scan makanan lewat camera",
                onClick: () async {
                  await callback(await pickImage(PickType.Camera));
                  Navigator.pop(context);
                }),

            
            pickWidget(
                iconPath:
                    Icon(Icons.browse_gallery, color: Colors.white, size: 30),
                title: "Scan lewat gallery",
                onClick: () async {
                  await callback(await pickImage(PickType.Gallery));
                  Navigator.pop(context);
                })
          ],
        )
      ],
    );
  }

  static Widget pickWidget(
      {required Icon iconPath,
      required String title,
      required Function onClick}) {
    return Column(
      mainAxisAlignment:  MainAxisAlignment.center,
      crossAxisAlignment:  CrossAxisAlignment.center,
      children: [
        Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom:  10),
            height: 100,
            decoration:
                BoxDecoration(
                  border:  Border.all(color: primaryColor, width: 2),
                   color: Colors.white , borderRadius: BorderRadius.circular(10) , ),  
            child: GestureDetector(
              onTap: () => onClick(),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: Text(title, style:  normalText.copyWith( fontSize: 16, color: primaryColor ,),)),
              ),
            )),
      
      ],
    );
  }
}
