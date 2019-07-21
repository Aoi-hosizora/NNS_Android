import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../../Models/Lists/KiziListItem.dart';
import '../../Models/OnlineListDataMgr.dart';
import '../../Constants/Consts.dart';
import '../../Constants/Strings.dart';
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
            _onAfterBuild();
        });
    }

    void _onAfterBuild() async {
        _repo = OnlineListDataMgr.getInstance();
        _more = WidgetUtil.getMoreCard(moreText: Strings.MoreGet, onTap: () async {
            _listView = WidgetUtil.addLoadingRemoveAdd(_listView, load: _load, more: _more);
            setState(() {}); // add refresh
            await _refreshData();
        });
        _load = WidgetUtil.getLoadingCard();  
        
        _listView = <Widget>[
            LinearProgressIndicator()
        ];
        setState(() {});

        _repo.initShigotoKizis();
        await _refreshData();
    }

    @override
    void dispose() {
        CommonUtil.loge("_ShigotoTabState", "dispose");
        super.dispose();
    }

    /// getData from net
    /// 
    /// @param `isNewData`
    ///    -  false: continue `_repo.Cnt` to get Data
    ///    - true: get Data from 1 page
    Future<void> _refreshData({bool isNewData: false}) async {
        if (isNewData) _repo.initShigotoKizis();

        int oldCnt = _repo.shigotoKizis.length;
        for (var i = 0; i < Consts.KiziPagesForOneRefresh; i++) 
            try {
                List<KiziListItem> newkizis = await NetUtil.getSHIGOTOPageData(page: ++_repo.shigotoKiziCnt);
                CommonUtil.loge("_refreshData", "_repo.shikotoKiziCnt: " + _repo.shigotoKiziCnt.toString());
                _repo.shigotoKizis.addAll(newkizis);
            }
            on HttpException {
                CommonUtil.showToast(Strings.NetWorkError);
                return;
            }
            catch (ex) {
                CommonUtil.showToast(Strings.UnknownError);
                return;
            }
        
        int newCnt = _repo.shigotoKizis.length;
        CommonUtil.showToast(sprintf(Strings.KiziUpdateToast, [Strings.ShigotoTab, newCnt - oldCnt]));

        _refreshWidget();
    }

    /// after get data, load widget for all data
    void _refreshWidget() {
        _listView = <Widget>[];
        for (var kizi in _repo.shigotoKizis) 
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

    /// RefreshIndicator `onRefresh`
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