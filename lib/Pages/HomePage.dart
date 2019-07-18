import 'package:flutter/material.dart';

import '../Constants/Strings.dart';
import '../Constants/Dimens.dart';
import '../Constants/Styles.dart';

import './Tabs/HomeTab.dart';
import './Tabs/GammarTab.dart';
import './Tabs/ColumnTab.dart';
import './Tabs/CategoryTab.dart';

class HomePage extends StatefulWidget {
	
	final String title = Strings.HomePageTitle;

	HomePage({Key key}) : super(key: key);
	
	@override
	State<HomePage> createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage> {

    /// Tab Strings(From Strings)
    List<String> _tabs = <String>[
        Strings.HomeTab, Strings.GammarTab, Strings.ColumnTab, Strings.CategoryTab
    ];

    /// Get Tab Content Widget
    /// 
    /// @param `tab` Tab title
    Widget _getTab(String tab) {
        switch (tab) {
            case Strings.HomeTab:
                return HomeTab();
            case Strings.GammarTab:
                return GammarTab();
            case Strings.ColumnTab:
                return ColumnTab();
            case Strings.CategoryTab:
                return CategoryTab();
        }
        return Center(
            child: Text(Strings.Error)
        );
    }
    
    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            length: _tabs.length,
            child: Scaffold(
                appBar: AppBar(
                    title: Text(Strings.HomePageTitle, style: Styles.NormalTextStyle),
                    bottom: TabBar(
                        isScrollable: true,
                        tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
                        labelStyle: Styles.NormalTextStyle
                    )
                ),
                body: TabBarView(children: _tabs.map((String tab) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.TabPaddingV,
                            vertical: Dimens.TabPaddingH
                        ),
                        child: _getTab(tab)
                    );
                }).toList())
            )
        );
    }
}
