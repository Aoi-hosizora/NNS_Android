import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../../Models/Lists/KiziListItem.dart';
import '../../Constants/Styles.dart';
import '../../Constants/Strings.dart';
import '../../Constants/Consts.dart';
import '../../Utils/CommonUtil.dart';
import '../../Utils/NetUtil.dart';

class ShikotoTab extends StatefulWidget {
    ShikotoTab({Key key}) : super(key: key);

    @override
    State<ShikotoTab> createState() => new _ShikotoTabState();
}

class _ShikotoTabState extends State<ShikotoTab> with AutomaticKeepAliveClientMixin {

    var _kiziList, _more;

    int _currListCnt = 0;

    @override
    void initState() {
        super.initState();
        _kiziList = <Widget>[];
        _more = Card(
            child: ListTile(
                title: Center(child: Text(Strings.More, style: Styles.TitleTextStyle)),
                onTap: () => _refreshData()
            ),
        );
        _refreshData();
    }

    void _refreshData() async {
        
        var widgetList = new List<Widget>();
        widgetList.addAll(_kiziList);

        if (widgetList.contains(_more))
            widgetList.remove(_more);

        int motoCnt = widgetList.length, nowCnt;

        for (var i = 0; i < Consts.KiziPagesForOneRefresh; i++) {

            List<KiziListItem> kizis = await NetUtils.getSHIGOTOPageData(page: ++_currListCnt);
            CommonUtil.loge("_refreshData", "_currListCnt: " + _currListCnt.toString());

            for (var item in kizis) 
                widgetList.add(
                    Card(
                        child: ListTile(
                            title: Text(
                                item.title,
                                style: Styles.TitleTextStyle, 
                                maxLines: Consts.CardTitleMaxLine, overflow: TextOverflow.ellipsis
                            ),
                            subtitle: Text(
                                item.arasuzi, 
                                style: Styles.SubTitleTextStyle, 
                                maxLines: Consts.CardSubTitleMaxLine, overflow: TextOverflow.ellipsis
                            ),
                            trailing: Text(
                                    item.date, 
                                    style: Styles.SubTitleTextStyle
                            ),
                            onTap: () => CommonUtil.showToast(item.url),
                        )
                    )
                );      
        }
        
        nowCnt = widgetList.length;
        widgetList.add(_more);

        // CommonUtil.showToast(sprintf(Strings.KiziUpdateToast, [nowCnt - motoCnt]));
        setState(() => _kiziList = widgetList );
    }
    
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return ListView(
            children: _kiziList
        );
    }
}