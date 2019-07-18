import 'package:flutter/material.dart';

import '../../Constants/Strings.dart';
import '../../Constants/Styles.dart';

class ColumnTab extends StatefulWidget {
    ColumnTab({Key key}) : super(key: key);

    @override
    State<ColumnTab> createState() => new _ColumnTabState();
}

class _ColumnTabState extends State<ColumnTab> {
    @override
    Widget build(BuildContext context) {
        return Text(Strings.ColumnTab, style: Styles.GrayTextStyle);
    }
}