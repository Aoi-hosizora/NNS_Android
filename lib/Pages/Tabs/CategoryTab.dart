import 'package:flutter/material.dart';

import '../../Constants/Strings.dart';
import '../../Constants/Styles.dart';
import '../../Models/OnlineListDataMgr.dart';

class CategoryTab extends StatefulWidget {
    CategoryTab({Key key}) : super(key: key);

    @override
    State<CategoryTab> createState() => new _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> with AutomaticKeepAliveClientMixin {

    OnlineListDataMgr _repo;

    @override
    void initState() { 
        super.initState();
        WidgetsBinding.instance.addPostFrameCallback((callback) {
            _repo = OnlineListDataMgr.getInstance();
            if (_repo.isFirstInit_CategoryTab) {
                //
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Center(child: Text(Strings.CategoryTab, style: Styles.GrayTextStyle));
    }
    
    @override
    bool get wantKeepAlive => true;
}