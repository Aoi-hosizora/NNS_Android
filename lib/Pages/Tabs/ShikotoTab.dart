import 'package:flutter/material.dart';

import '../../Models/Lists/KiziListItem.dart';
import '../../Models/OnlineListDataMgr.dart';
import '../../Constants/Consts.dart';
import '../../Utils/CommonUtil.dart';
import '../../Utils/NetUtil.dart';
import '../../Utils/WidgetUtil.dart';

class ShikotoTab extends StatefulWidget {
    ShikotoTab({Key key}) : super(key: key);

    @override
    State<ShikotoTab> createState() => new _ShikotoTabState();
}

class _ShikotoTabState extends State<ShikotoTab> with AutomaticKeepAliveClientMixin {

    Card _more;
    List<Widget> _listView = <Widget>[];
    OnlineListDataMgr _repo;

    @override
    void initState() {
        super.initState();
        CommonUtil.loge("_ShikotoTabState", "initState");
        
        _repo = OnlineListDataMgr.getInstance();
        _more = WidgetUtil.getMoreCard(onTap: () => _refreshData());
        _refreshData();
    }

    @override
    void dispose() {
        CommonUtil.loge("_ShikotoTabState", "dispose");
        super.dispose();
    }

    Future<void> _refreshData({bool isNewData: false}) async {
        // TODO add toast(save state problem)
        if (isNewData) {
            _repo.shikotoKiziCnt = 0;
            _repo.shikotoKizis.clear();
        }

        for (var i = 0; i < Consts.KiziPagesForOneRefresh; i++) {
            List<KiziListItem> newkizis = await NetUtils.getSHIGOTOPageData(page: ++_repo.shikotoKiziCnt);
            CommonUtil.loge("_refreshData", "_repo.shikotoKiziCnt: " + _repo.shikotoKiziCnt.toString());
            _repo.shikotoKizis.addAll(newkizis);
        }

        _listView = <Widget>[];
        for (var kizi in _repo.shikotoKizis) 
            // TODO route to Kizi Page
            _listView.add(WidgetUtil.getCardFromKiziListItem(kizi, () => CommonUtil.showToast(kizi.url)));
        _listView.add(_more);

        setState(() {});
    }

    Future<void> _onRefresh() async {
        await _refreshData(isNewData: true);
    }
    
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return RefreshIndicator(
            child: ListView(
                children: _listView
            ),
            onRefresh: () => _onRefresh()
        );
    }
}