import 'package:flutter/material.dart';

import '../../Models/Lists/KiziListItem.dart';
import '../../Models/OnlineListDataMgr.dart';
import '../../Constants/Consts.dart';
import '../../Constants/Dimens.dart';
import '../../Utils/CommonUtil.dart';
import '../../Utils/NetUtil.dart';
import '../../Utils/WidgetUtil.dart';
import '../KiziPage.dart';

class ShigotoTab extends StatefulWidget {
    ShigotoTab({Key key}) : super(key: key);

    @override
    State<ShigotoTab> createState() => new _ShigotoTabState();
}

class _ShigotoTabState extends State<ShigotoTab> with AutomaticKeepAliveClientMixin {

    Card _more;
    Card _load;
    List<Widget> _listView = <Widget>[];
    OnlineListDataMgr _repo;

    @override
    void initState() {
        super.initState();
        CommonUtil.loge("_ShikotoTabState", "initState");
        
        WidgetsBinding.instance.addPostFrameCallback((callback) {
            _repo = OnlineListDataMgr.getInstance();
            if (_repo.isFirstInit_ShigotoTab) {
                _more = WidgetUtil.getMoreCard(onTap: () {
                    _listView = WidgetUtil.addLoadingRemoveAdd(_listView, load: _load, more: _more);
                    setState(() {});
                    _refreshData();
                });
                _load = WidgetUtil.getLoadingCard();
                _refreshData();                
            }
        });
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
            List<KiziListItem> newkizis = await NetUtil.getSHIGOTOPageData(page: ++_repo.shikotoKiziCnt);
            CommonUtil.loge("_refreshData", "_repo.shikotoKiziCnt: " + _repo.shikotoKiziCnt.toString());
            _repo.shikotoKizis.addAll(newkizis);
        }

        _listView = <Widget>[];
        for (var kizi in _repo.shikotoKizis) 
            _listView.add(WidgetUtil.getCardFromKiziListItem(kizi, () =>
                Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (context) => KiziPage(kizi: kizi)
                    )
                )
            ));
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