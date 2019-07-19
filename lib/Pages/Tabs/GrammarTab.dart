import 'dart:collection';
import 'package:flutter/material.dart';

import '../../Constants/Consts.dart';
import '../../Models/OnlineListDataMgr.dart';
import '../../Models/Lists/GrammarListItem.dart';
import '../../Utils/NetUtil.dart';
import '../../Utils/CommonUtil.dart';
import '../../Utils/WidgetUtil.dart';

class GrammarTab extends StatefulWidget {
    GrammarTab({Key key}) : super(key: key);

    @override
    State<GrammarTab> createState() => new _GrammarTabState();
}

class _GrammarTabState extends State<GrammarTab> with AutomaticKeepAliveClientMixin {

    var _moreList = HashMap<String, Card>();
    var _cardList = HashMap<String, List<Card>>();
    OnlineListDataMgr _repo;

    @override
    void initState() {
        super.initState();
        CommonUtil.loge("_GrammarTabState", "initState");

        _repo = OnlineListDataMgr.getInstance();
        GrammarListItem.GrammarClass.forEach((gc) {
             _moreList[gc] = WidgetUtil.getMore(() => CommonUtil.showToast(gc));
        });
        _getData(); 
    }

    @override
    void dispose() {
        CommonUtil.loge("_GrammarTabState", "dispose");
        super.dispose();
    }

    void _getData() async {
        // Data need update
        if (_repo.grammarLists.length != GrammarListItem.GrammarClass.length) {
            _cardList = HashMap<String, List<Card>>();
            for (String gc in GrammarListItem.GrammarClass) {
                _repo.grammarLists[gc] = await NetUtils.getGrammarPageData(gc);
                CommonUtil.loge("_getData", _repo.grammarLists[gc].length);
                _cardList[gc] = <Card>[];
                for (var g in _repo.grammarLists[gc].sublist(Consts.GrammarListMinCnt)) {
                    _cardList[gc].add(WidgetUtil.getCardFromGrammarListItem(g, () => CommonUtil.showToast(g.url)));
                }
                setState(() {});  
            }
        }
    }

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return GridView.count(
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 30.0,
            padding: EdgeInsets.all(10.0),
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            children: GrammarListItem.GrammarClass.map((gm) => 
                WidgetUtil.getCompleteGrammarListViewFromHashMap(_cardList, _moreList, gm)
            ).toList()
        );
    }
}