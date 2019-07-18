import 'package:flutter/material.dart';

import '../../Constants/Strings.dart';
import '../../Constants/Styles.dart';

class GammarTab extends StatefulWidget {
    GammarTab({Key key}) : super(key: key);

    @override
    State<GammarTab> createState() => new _GammarTabState();
}

class _GammarTabState extends State<GammarTab> {
    @override
    Widget build(BuildContext context) {
        return Text(Strings.GammarTab, style: Styles.GrayTextStyle);
    }
}