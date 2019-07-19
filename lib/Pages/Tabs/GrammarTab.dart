import 'package:flutter/material.dart';

import '../../Constants/Strings.dart';
import '../../Constants/Styles.dart';
import '../../Constants/Consts.dart';
import '../../Models/Lists/GrammarListItem.dart';
import '../../Utils/CommonUtil.dart';
import '../../Utils/NetUtil.dart';

class GrammarTab extends StatefulWidget {
    GrammarTab({Key key}) : super(key: key);

    @override
    State<GrammarTab> createState() => new _GrammarTabState();
}

class _GrammarTabState extends State<GrammarTab> with AutomaticKeepAliveClientMixin {

    var _grammarList = <List<GrammarListItem>>[];
    var _more = <Card>[];

    @override
    void initState() {
        super.initState();

        GrammarListItem.GrammarClass.forEach((gc) {
             _more.add(Card(
                child: ListTile(
                    title: Center(child: Text(Strings.More, style: Styles.TitleTextStyle)),
                    onTap: () => CommonUtil.showToast(gc),
                )
            ));
        });
       
        _getDataList(); 
    }

    /// get Grammar List
    void _getDataList() async {
        var retGrammarList = <List<GrammarListItem>>[];

        GrammarListItem.GrammarClass.forEach((gc) async {
            retGrammarList.add(await NetUtils.getGrammarPageData(gc));
            setState(() => _grammarList = retGrammarList );
        });
    }

    /// parse to ListView
    /// 
    /// @param `items` List<GrammarListItem>
    ListView _getCardList(List<GrammarListItem> items) {
        var cards = <Widget>[];
        for (var item in items.sublist(1)) {
            cards.add(
                Card(
                    child: ListTile(
                        title: Text(item.title, style: Styles.TitleTextStyle)
                    )
                )
            );
        }
        return ListView(
            children: cards
        );
    }

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return GridView.count(
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 30.0,
            padding: EdgeInsets.all(10.0),
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            children: _grammarList.map((g) => _getCardList(g)).toList()
        );
    }
}