import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../../Models/OnlineListDataMgr.dart';
import '../../Models/Lists/KiziListItem.dart';
import '../../Constants/Consts.dart';
import '../../Constants/Strings.dart';
import '../../Utils/CommonUtil.dart';
import '../../Utils/NetUtil.dart';
import '../../Utils/WidgetUtil.dart';
import '../KiziPage.dart';

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
            _refreshWidget();
        });
        _load = WidgetUtil.getLoadingCard(); 

        if (_repo.isFirstInitSeikakuTab) {
            _listView = <Widget>[
                WidgetUtil.getLoadingTile()
            ];
            setState(() {});
            _repo.initSeikakuKizis(); // TODO Ostrich code
            if (await _refreshData())
                _repo.isFirstInitSeikakuTab = false;      
        }
        _refreshWidget();
    }

    @override
    void dispose() {
        CommonUtil.loge("_SeikatuTabState", "dispose");
        super.dispose();
    }

    /// getData from net
    /// 
    /// @param `isNewData`
    ///    -  false: continue `_repo.Cnt` to get Data
    ///    - true: get Data from 1 page
    /// 
    /// @return `bool` isSuccess
    Future<bool> _refreshData({bool isNewData: false}) async {
        if (isNewData) _repo.initSeikakuKizis();

        int oldCnt = _repo.seikatuKizis.length;
        for (var i = 0; i < Consts.KiziPagesForOneRefresh; i++) {
            List<KiziListItem> newkizis;
            try {
                newkizis = await NetUtil.getSEIKATUPageData(page: ++_repo.seikatuKiziCnt);
            }
            on HttpException {
                CommonUtil.showToast(Strings.NetWorkError);
                return false;
            }
            catch (ex) {
                CommonUtil.showToast(Strings.UnknownError);
                return false;
            }
            
            CommonUtil.loge("_refreshData", "_repo.seikatuKiziCnt: " + _repo.seikatuKiziCnt.toString());
            _repo.seikatuKizis.addAll(newkizis);
        }
        int newCnt = _repo.seikatuKizis.length;

        CommonUtil.showToast(sprintf(Strings.KiziUpdateToast, [Strings.KiziTypeSeikatu, newCnt - oldCnt]));
        return true;
    }

    /// after get data, load widget for all data
    void _refreshWidget() {
        _listView = <Widget>[];
        for (var kizi in _repo.seikatuKizis)
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
        // final Size size = MediaQuery.of(context).size;
        return RefreshIndicator(
            child: ListView(
                children: _listView
            ),
            onRefresh: () => _onRefresh()
        );
    }
}