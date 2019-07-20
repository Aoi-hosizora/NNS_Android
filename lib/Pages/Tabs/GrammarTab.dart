import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nihongo_no_sensei/Constants/Dimens.dart';

import '../../Constants/Consts.dart';
import '../GrammarPage.dart';
import '../../Models/OnlineListDataMgr.dart';
import '../../Utils/NetUtil.dart';
import '../../Utils/CommonUtil.dart';
import '../../Utils/WidgetUtil.dart';

class GrammarTab extends StatefulWidget {
    GrammarTab({Key key}) : super(key: key);

    @override
    State<GrammarTab> createState() => new _GrammarTabState();
}

class _GrammarTabState extends State<GrammarTab> with AutomaticKeepAliveClientMixin {

    var _moreList = HashMap<String, ListTile>();
    var _gmrsList = HashMap<String, List<ListTile>>();
    OnlineListDataMgr _repo;

    @override
    void initState() {
        super.initState();
        CommonUtil.loge("_GrammarTabState", "initState");

        WidgetsBinding.instance.addPostFrameCallback((callback) {
            _repo = OnlineListDataMgr.getInstance();
            if (_repo.isFirstInit_GrammarTab) {
                Consts.GrammarClass.forEach((gc) { // 6
                    _moreList[gc] = WidgetUtil.getMoreTile(onTap: () => _onPressMore(gc));
                });
                _getData();
            }
        });
    }

    void _onPressMore(String grammarClass) =>
        CommonUtil.showBottomSheet(
            context: context,
            content: ListView(
                children: WidgetUtil.getCompleteGrammarClassListFromHashMap(
                    grammarClass,
                    gmrslists: _gmrsList
                )
            )
        );

    @override
    void dispose() {
        CommonUtil.loge("_GrammarTabState", "dispose");
        super.dispose();
    }

    void _getData() async {
        // TODO add toast(save state problem)
        // Data need update
        if (_repo.grammarLists.length != Consts.GrammarClass.length) {
            _gmrsList = HashMap<String, List<ListTile>>();
            for (String gc in Consts.GrammarClass) {
                _repo.grammarLists[gc] = await NetUtil.getGrammarPageData(gc);
                CommonUtil.loge("_getData", _repo.grammarLists[gc].length);
                _gmrsList[gc] = <ListTile>[];
                for (var g in _repo.grammarLists[gc])
                    _gmrsList[gc].add(WidgetUtil.getListTileFromGrammarListItem(g, () =>
                        Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (context) => GrammarPage(gmr: g)
                            )
                        )
                    ));
                setState(() {});  
            }
        }
    }

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return StaggeredGridView.countBuilder(
            primary: false,
            crossAxisSpacing: Dimens.StaggerCrossAxisSpacing,
            mainAxisSpacing: Dimens.StaggerMainAxisSpacing,
            crossAxisCount: Dimens.StaggerCrossAxisCount,
            itemCount: Consts.GrammarClass.length,
            itemBuilder: (context, index) =>
                Card(
                    child: Column(
                        children: WidgetUtil.getCompleteGrammarClassListFromHashMap(
                            Consts.GrammarClass[index],
                            gmrslists: _gmrsList, morelists: _moreList, gmrCnt: Consts.GrammarListMinCnt
                        )
                    )
                ),
            staggeredTileBuilder: (index) => StaggeredTile.fit(Dimens.StaggerFitCrossAxisCount),
        );
    }
}

// https://www.keppel.fun/articles/2019/04/26/1556245200876.html