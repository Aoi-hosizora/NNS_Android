import 'package:flutter/material.dart';

import '../../Constants/Strings.dart';
import '../../Constants/Styles.dart';

class HomeTab extends StatefulWidget {
    HomeTab({Key key}) : super(key: key);

    @override
    State<HomeTab> createState() => new _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
    @override
    Widget build(BuildContext context) {
        return Text(Strings.HomeTab, style: Styles.GrayTextStyle);
    }
}