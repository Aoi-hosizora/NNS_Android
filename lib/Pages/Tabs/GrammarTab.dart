import 'dart:io';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nihongo_no_sensei/Constants/Dimens.dart';

import '../../Constants/Consts.dart';
import '../../Constants/Strings.dart';
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
            _onAfterBuild();
        });
    }

    void _onAfterBuild() async {
        _repo = OnlineListDataMgr.getInstance();
        Consts.GrammarClass.forEach((gc) { // 6
            _moreList[gc] = WidgetUtil.getMoreTile(moreText: Strings.MoreLoad, onTap: () => _onPressMore(gc));
        });
        setState(() {});
        await _refreshAllWidget(isContainData: true);
    }

    @override
    void dispose() {
        CommonUtil.loge("_GrammarTabState", "dispose");
        super.dispose();
    }

    /// get gmr data of gc
    /// 
    /// @param `gc`
    Future<void> _getData(String gc) async {
        try {
            _repo.grammarLists[gc] = await NetUtil.getGrammarPageData(gc);
        }
        on HttpException {
            CommonUtil.showToast(Strings.NetWorkError);
            return;
        }
        catch (ex) {
            CommonUtil.showToast(Strings.UnknownError);
            return;
        }
        CommonUtil.loge("_getData", gc + ": " + _repo.grammarLists[gc].length.toString());
    }

    /// load widget of gc
    /// 
    /// @param `gc`
    void _refreshWidget(String gc) {
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

    /// get / load all
    /// 
    /// @param `isContainData`
    ///    - false: only load all widget of all gc
    ///    - true: both get data and load widget of all gc
    Future<void> _refreshAllWidget({@required bool isContainData}) async {
        for (String gc in Consts.GrammarClass) {
            if (isContainData) 
                await _getData(gc);
            _refreshWidget(gc);
        }
    }

    /// handle getMoreTile `onPress` to show Bottom Sheet 
    /// 
    /// @param `gc`
    void _onPressMore(String gc) =>
        CommonUtil.showBottomSheet(
            context: context,
            content: ListView(
                children: WidgetUtil.getCompleteGrammarClassListFromHashMap(
                    gc,
                    gmrslists: _gmrsList
                )
            )
        );

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