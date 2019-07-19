import 'package:flutter/material.dart';

import '../../Utils/NetUtil.dart';
import '../../Utils/CommonUtil.dart';
import '../../Models/Lists/GrammarListItem.dart';

class HomeTab extends StatefulWidget {
    HomeTab({Key key}) : super(key: key);

    @override
    State<HomeTab> createState() => new _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  
    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[
                OutlineButton(
                    onPressed: () => NetUtils.getSHIGOTOPageData().then((items) => CommonUtil.showToast(items)),
                    child: Text("仕事"),
                ),
                OutlineButton(
                    onPressed: () => NetUtils.getSEIKATUPageData().then((items) => CommonUtil.showToast(items)),
                    child: Text("生活"),
                ),
                OutlineButton(
                    onPressed: () => NetUtils.getGrammarPageData(GrammarListItem.N1W).then((items) => CommonUtil.showToast(items)),
                    child: Text("文法"),
                )
            ]
        );
    }
}