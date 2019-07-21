import 'package:flutter/material.dart';

import '../../Utils/CommonUtil.dart';
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
            _onAfterBuild();
        });
    }

    void _onAfterBuild() {
        _repo = OnlineListDataMgr.getInstance();
    }

    @override
    void dispose() {
        CommonUtil.loge("_GrammarTabState", "dispose");
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Center(child: Text(Strings.CategoryTab, style: Styles.GrayTextStyle));
    }
    
    @override
    bool get wantKeepAlive => true;
}