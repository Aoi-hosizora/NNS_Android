import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants/Dimens.dart';
import '../Constants/Strings.dart';

class CommonUtil {

    CommonUtil._();

    /// Show Toast
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

    /// Show Alert Dlg
    /// 
    /// @param `title` `message` 
    /// 
    /// @param `actions` <Widget>[FlatButton]
    /// 
    /// @param `barrierDismissible`
    static void showAlert({
        @required BuildContext context, 
        @required Widget title, @required Widget message, 
        List<Widget> actions, 
        bool barrierDismissible: true
    }) =>
            showDialog(
                context: context,
                barrierDismissible: barrierDismissible,
                builder: (BuildContext context) =>
                    AlertDialog(
                        title: title,
                        content: message,
                        actions: actions,
                    )
            );

    /// Show Alert Dlg
    /// 
    /// @param `title` `message` 
    /// 
    /// @param `barrierDismissible`
    static void showProgress({
        @required BuildContext context, 
        Widget title, @required Widget message, 
        bool barrierDismissible: true
    }) =>
        showAlert(
            context: context, 
            title: title,
            barrierDismissible: barrierDismissible,
            message: Row(
                children: <Widget>[
                    Padding(
                        child: CircularProgressIndicator(),
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.CircularProgressHorizontalPadding
                        ),
                    ),
                    Padding(
                        child: message,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.CircularProgressMessageHorizontalPadding
                        ),
                    )
                ]
            )
        );

    /// show Modal Bottom Sheet
    /// 
    /// @param `content` Widget
    static void showBottomSheet({
        @required BuildContext context,
        @required Widget content,
    }) =>
        showModalBottomSheet(
            context: context,
            builder: (context) =>
                Container(
                    child: content,
                )
        );

    /// Use Browser to open hp
    static void openBrowser(String url) async {
        if (await canLaunch(url))
            // forceWebView: true <- Widget Poi
            launch(url);
        else
           CommonUtil.showToast(Strings.OpenUrlErrorToast);
    }

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
