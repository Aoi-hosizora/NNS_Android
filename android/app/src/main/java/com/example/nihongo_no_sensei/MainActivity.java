package com.example.nihongo_no_sensei;

import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {

    private final String FLUTTER_LOG_CHANNEL = "android_log";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), FLUTTER_LOG_CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
                @Override
                public void onMethodCall(MethodCall call, Result result) {
                    PrintLog(call);
                }
            });
        }

    /**
     * Naive show log from flutter
     * @param call
     * _channel.invokeMethod('$method', {'tag': '$tag', 'message': '$message'});
     */
    private void PrintLog(MethodCall call) {
        String tag = call.argument("tag");
        String message = call.argument("message");
        
        if (tag == null) tag = "";
        if (message == null) message = "";

        switch (call.method) {
            case "logV":
                Log.v(tag, message);
            break;
            case "logD":
                Log.d(tag, message);
            break;
            case "logI":
                Log.i(tag, message);
            break;
            case "logW":
                Log.w(tag, message);
            break;
            case "logE":
                Log.e(tag, message);
            break;
        }
    }
}

// https://www.jianshu.com/p/d9eeb15b3fa0