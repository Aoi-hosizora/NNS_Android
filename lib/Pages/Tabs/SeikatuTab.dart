import 'package:flutter/material.dart';

import '../../Models/OnlineListDataMgr.dart';
import '../../Models/Lists/KiziListItem.dart';
import '../../Constants/Consts.dart';
import '../../Utils/CommonUtil.dart';
import '../../Utils/NetUtil.dart';
import '../../Utils/WidgetUtil.dart';

class SeikatuTab extends StatefulWidget {
    SeikatuTab({Key key}) : super(key: key);

    @override
    State<SeikatuTab> createState() => new _SeikatuTabState();
}

class _SeikatuTabState extends State<SeikatuTab> with AutomaticKeepAliveClientMixin {

    Card _more;
    Card _load;
    List<Widget> _listView = <Widget>[];
    OnlineListDataMgr _repo;

    @override
    void initState() {
        super.initState();
        CommonUtil.loge("_SeikatuTabState", "initState");
        
        _repo = OnlineListDataMgr.getInstance();
        _more = WidgetUtil.getMoreCard(onTap: () {
            _listView = WidgetUtil.addLoadingRemoveAdd(_listView, load: _load, more: _more);
            setState(() {});
            _refreshData();
        });
        _load = WidgetUtil.getLoadingCard();
        _refreshData();
    }

    @override
    void dispose() {
        CommonUtil.loge("_SeikatuTabState", "dispose");
        super.dispose();
    }

    Future<void> _refreshData({bool isNewData: false}) async {
        // TODO add toast(save state problem)
        if (isNewData) {
            _repo.seikatuKiziCnt = 0;
            _repo.seikatuKizis.clear();
        }

        for (var i = 0; i < Consts.KiziPagesForOneRefresh; i++) {
            List<KiziListItem> newkizis = await NetUtils.getSEIKATUPageData(page: ++_repo.seikatuKiziCnt);
            CommonUtil.loge("_refreshData", "_repo.seikatuKiziCnt: " + _repo.seikatuKiziCnt.toString());
            _repo.seikatuKizis.addAll(newkizis);
        }

        _listView = <Widget>[];
        for (var kizi in _repo.seikatuKizis) 
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
        // final Size size = MediaQuery.of(context).size;
        return RefreshIndicator(
            child: ListView(
                children: _listView
            ),
            onRefresh: () => _onRefresh()
        );
    }
}