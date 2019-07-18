import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonUtil {

    CommonUtil._();

    /// 显示底部 Toast
    /// 
    /// @param `msg` dynamic
    static void showToast(dynamic msg) =>
        Fluttertoast.showToast(
            msg: msg.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white
        );

    /// Channel comm with Naive
    static const _channel = const MethodChannel("android_log");

    static void loge(String tag, dynamic message) =>
        _channel.invokeMethod('logE', {'tag': tag, 'message': message.toString()});
    
    static void logv(String tag, dynamic message) =>
        _channel.invokeMethod('logV', {'tag': tag, 'message': message.toString()});
    
    static void logd(String tag, dynamic message) =>
        _channel.invokeMethod('logD', {'tag': tag, 'message': message.toString()});
    
    static void logi(String tag, dynamic message) =>
        _channel.invokeMethod('logI', {'tag': tag, 'message': message.toString()});
    
    static void logw(String tag, dynamic message) =>
        _channel.invokeMethod('logW', {'tag': tag, 'message': message.toString()});
}
