import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'color_picker.dart';

class LoadingDialog {
  void showDialog({String message = ""}) {
    Get.dialog(
        SimpleDialog(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    color: CPicker.primary,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  )
                ],
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          // shape:OutlineInputBorder(borderSide: BorderSide(width: 1,color: ThemeColor.accentColor),borderRadius: BorderRadius.circular(10)),
        ),
        barrierColor: Colors.transparent,
        barrierDismissible: false);
  }

  void hideDialog() {
    Get.back();
  }
}
