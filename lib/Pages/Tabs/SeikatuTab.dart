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
    List<Widget> _listView = <Widget>[];
    OnlineListDataMgr _repo;

    @override
    void initState() {
        super.initState();
        CommonUtil.loge("_SeikatuTabState", "initState");
        
        _repo = OnlineListDataMgr.getInstance();
        _more = WidgetUtil.getMore(() => _refreshData());
        _refreshData();
    }

    @override
    void dispose() {
        CommonUtil.loge("_SeikatuTabState", "dispose");
        super.dispose();
    }

    void _refreshData() async {
        for (var i = 0; i < Consts.KiziPagesForOneRefresh; i++) {
            List<KiziListItem> newkizis = await NetUtils.getSEIKATUPageData(page: ++_repo.seikatuKiziCnt);
            CommonUtil.loge("_refreshData", "_repo.seikatuKiziCnt: " + _repo.seikatuKiziCnt.toString());
            _repo.seikatuKizis.addAll(newkizis);
        }

        _listView = <Widget>[];
        for (var kizi in _repo.seikatuKizis) 
            _listView.add(WidgetUtil.getCardFromKiziListItem(kizi, () => CommonUtil.showToast(kizi.url)));
        _listView.add(_more);

        setState(() {});
    }

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        // final Size size = MediaQuery.of(context).size;
        return ListView(
            children: _listView
        );
    }
}