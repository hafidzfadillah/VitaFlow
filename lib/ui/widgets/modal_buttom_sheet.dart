import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class ModalBottomSheet {
  static void show({
    required String title,
    required List<Widget> children,
    required BuildContext context,
    double radiusCircle = 0,
    bool isDismisslable = true,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: isDismisslable,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusCircle),
              topRight: Radius.circular(radiusCircle))),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: normalText.copyWith(fontSize: 16, fontWeight:  FontWeight.w600),
                  ),
                  
                  SizedBox(
                    height: 10,
                  ),
                                    Text(
                      "Kamu bisa cari makanan yang sedang kamu makan lewat photo (Untuk sekarang hanya beberapa makanan yang tersedia)" ),

                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
