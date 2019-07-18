import 'package:flutter/material.dart';

import '../../Utils/NetUtil.dart';
import '../../Utils/CommonUtil.dart';

class HomeTab extends StatefulWidget {
    HomeTab({Key key}) : super(key: key);

    @override
    State<HomeTab> createState() => new _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  
    @override
    Widget build(BuildContext context) {
        return Column(children: <Widget>[
            OutlineButton(
                onPressed: () => NetUtils.getNNSData().then((resp) => CommonUtil.showToast(resp)),
            )
        ],);
    }
}