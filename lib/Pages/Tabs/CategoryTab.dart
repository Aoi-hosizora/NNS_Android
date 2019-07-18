import 'package:flutter/material.dart';

import '../../Constants/Strings.dart';
import '../../Constants/Styles.dart';

class CategoryTab extends StatefulWidget {
    CategoryTab({Key key}) : super(key: key);

    @override
    State<CategoryTab> createState() => new _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
    @override
    Widget build(BuildContext context) {
        return Text(Strings.CategoryTab, style: Styles.GrayTextStyle);
    }
}