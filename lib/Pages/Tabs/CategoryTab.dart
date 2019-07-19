import 'package:flutter/material.dart';

import '../../Constants/Strings.dart';
import '../../Constants/Styles.dart';

class CategoryTab extends StatefulWidget {
    CategoryTab({Key key}) : super(key: key);

    @override
    State<CategoryTab> createState() => new _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> with AutomaticKeepAliveClientMixin {

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Text(Strings.CategoryTab, style: Styles.GrayTextStyle);
    }
    
    @override
    bool get wantKeepAlive => true;
}