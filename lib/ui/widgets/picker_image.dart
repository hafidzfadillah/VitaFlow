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
      title: "Pilih Lokasi Gambar",
      context: context,
      radiusCircle: 40,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pickWidget(
                iconPath: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                title: "Kamera",
                onClick: () async {
                  await callback(await pickImage(PickType.Camera));
                  Navigator.pop(context);
                }),
            pickWidget(
                iconPath:
                    Icon(Icons.browse_gallery, color: Colors.white, size: 30),
                title: "Galeri",
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
      children: [
        Container(
            width: 100,
            height: 100,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: primaryColor),
            child: GestureDetector(
              onTap: () => onClick(),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: iconPath,
              ),
            )),
        SizedBox(height: 10),
        Text(title, style: subtitleTextStyle.copyWith(fontSize: 18)),
      ],
    );
  }
}
