import 'package:flutter/material.dart';
import 'package:nihongo_no_sensei/Utils/CommonUtil.dart';
import 'package:nihongo_no_sensei/Utils/NetUtil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants/Strings.dart';
import '../Constants/Dimens.dart';
import '../Constants/Styles.dart';

import './Tabs/SeikatuTab.dart';
import './Tabs/GrammarTab.dart';
import './Tabs/ShikotoTab.dart';
import './Tabs/CategoryTab.dart';

class HomePage extends StatefulWidget {
	
	final String title = Strings.HomePageTitle;

	HomePage({Key key}) : super(key: key);
	
	@override
	State<HomePage> createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

    /// Tab Strings(From Strings)
    List<String> _tabs = <String>[
        Strings.SeikatuTab, Strings.ShikotoTab, Strings.GrammarTab, Strings.CategoryTab
    ];

    TabController _tabController;

    Widget _seikatuTab, _shikototab, _grammarTab, _categoryTab;

    @override
    void initState() {
        super.initState();
        
        _seikatuTab = SeikatuTab();
        _shikototab = ShikotoTab();
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
            case Strings.ShikotoTab:
                return _shikototab;
            case Strings.GrammarTab:
                return _grammarTab;
            case Strings.CategoryTab:
                return _categoryTab;
        }
        return Center(
            child: Text(Strings.Error)
        );
    }

    /// Use Browser to open hp
    void _openBrowser() async {
        if (await canLaunch(NetUtils.NNS_URL))
            // launch(NetUtils.NNS_HOME_URL, forceWebView: true); <- Widget Poi
            launch(NetUtils.NNS_URL);
        else
           CommonUtil.showToast(Strings.OpenUrlErrorToast);
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(Strings.HomePageTitle, style: Styles.NormalTextStyle),
                actions: <Widget>[
                    IconButton(
                        tooltip: Strings.OpenUrlToolBar,
                        icon: Icon(Icons.web),
                        onPressed: () => _openBrowser(),
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