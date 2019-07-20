import 'package:flutter/material.dart';

import '../Constants/Strings.dart';
import '../Constants/Dimens.dart';
import '../Constants/Styles.dart';
import '../Utils/CommonUtil.dart';
import '../Utils/NetUtil.dart';

import './Tabs/SeikatuTab.dart';
import './Tabs/GrammarTab.dart';
import './Tabs/ShigotoTab.dart';
import './Tabs/CategoryTab.dart';

class HomePage extends StatefulWidget {
    HomePage({Key key}) : super(key: key);
    
    @override
    State<HomePage> createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

    /// Tab Strings(From Strings)
    List<String> _tabs = <String>[
        Strings.SeikatuTab, Strings.ShigotoTab, Strings.GrammarTab, Strings.CategoryTab
    ];

    TabController _tabController;

    Widget _seikatuTab, _shigototab, _grammarTab, _categoryTab;

    @override
    void initState() {
        super.initState();
        
        _seikatuTab = SeikatuTab();
        _shigototab = ShigotoTab();
        _grammarTab = GrammarTab();
        _categoryTab = CategoryTab();

        _tabController = TabController(
            length: _tabs.length, 
            vsync: this
        )..addListener(() {
            if (_tabController.indexIsChanging)
                _tabController.animateTo(_tabController.index);
        });
    }

    @override
    void dispose() {
        super.dispose();
        _tabController.dispose();
    }
    
    /// Get Tab Content Widget
    /// 
    /// @param `tab` Tab title
    Widget _getTab(String tab) {
        switch (tab) {
            case Strings.SeikatuTab:
                return _seikatuTab;
            case Strings.ShigotoTab:
                return _shigototab;
            case Strings.GrammarTab:
                return _grammarTab;
            case Strings.CategoryTab:
                return _categoryTab;
        }
        return Center(
            child: Text(Strings.Error)
        );
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(Strings.HomePageTitle, style: Styles.NormalTextStyle),
                actions: <Widget>[
                    IconButton(
                        tooltip: Strings.OpenHPUrlToolBar,
                        icon: Icon(Icons.web),
                        onPressed: () => CommonUtil.openBrowser(NetUtil.NNS_URL),
                    )
                ],
                bottom: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
                    labelStyle: Styles.NormalTextStyle
                )
            ),
            body: TabBarView(
                controller: _tabController,
                children: _tabs.map((String tab) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.TabPaddingV,
                            vertical: Dimens.TabPaddingH
                        ),
                        child: _getTab(tab)
                    );
                }).toList()
            )
        );
    }
}

// https://www.jianshu.com/p/7f5b7e7d3c9a
// https://www.jianshu.com/p/87e545b889cd?tdsourcetag=s_pcqq_aiomsg