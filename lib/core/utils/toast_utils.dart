// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static showToast(String msg, ToastType toastType) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: getToastColor(toastType),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static getToastColor(ToastType toastType) {
    switch (toastType) {
      case ToastType.SUCCESS:
        return Colors.green;
      case ToastType.ERROR:
        return Colors.red;
      // return AppColors.primaryColor;
    }
  }
}

enum ToastType { SUCCESS, ERROR }
