import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonUtil {

    CommonUtil._();

    /// 显示底部 Toast
    /// 
    /// @param `msg` dynamic
    static void showToast(dynamic msg) {
        Fluttertoast.showToast(
            msg: msg.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white
        );
    }
}
