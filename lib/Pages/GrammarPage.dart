import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Models/Lists/GrammarListItem.dart';
import '../Models/Entities/GrammarItem.dart';
import '../Constants/Strings.dart';
import '../Constants/Styles.dart';
import '../Constants/Dimens.dart';
import '../Utils/CommonUtil.dart';
import '../Utils/NetUtil.dart';

class GrammarPage extends StatefulWidget {
    GrammarPage({@required this.gmr, Key key}) : super(key: key);

    final GrammarListItem gmr;

    @override
  State<StatefulWidget> createState() => new _GrammarPageState(gmr: gmr);
}

class _GrammarPageState extends State<GrammarPage> {

    _GrammarPageState({@required this.gmr});

    GrammarListItem gmr;
    GrammarItem _gmrItem;

    @override
    void initState() { 
        super.initState();
        _gmrItem = GrammarItem.fromList(gmr: gmr);
        WidgetsBinding.instance.addPostFrameCallback((callback) => _getData());
    }

    /// get Gmr Content Data from net, show Progress Dlg
    Future<void> _getData() async {
        CommonUtil.showProgress(context: context, message: Text(Strings.Loading, style: Styles.NormalTextStyle), barrierDismissible: false);
        _gmrItem = await NetUtil.getGmrContent(gmr);
        CommonUtil.loge("getData", "_kiziItem: " + _gmrItem.content.length.toString());
        Navigator.of(context).pop();
        setState(() {});
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(gmr.title, style: Styles.NormalTextStyle),
                actions: <Widget>[
                    IconButton(
                        tooltip: Strings.OpenWebSiteToolBar,
                        icon: Icon(Icons.web),
                        onPressed: () => CommonUtil.openBrowser(_gmrItem.url),
                    )
                ],
            ),
            body: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.PagePaddingV,
                    vertical: Dimens.PagePaddingH
                ),
                children: <Widget>[
                    Center(
                        child: Text(_gmrItem.title, style: Styles.KiziTitle)
                    ),
                    Text(_gmrItem.grammarClass, style: Styles.KiziSubTitle, textAlign: TextAlign.end),
                    Divider(),
                    // Text(_kiziItem.content),
                    Html(
                        data: _gmrItem.content,
                        padding: EdgeInsets.all(Dimens.HTMLPadding),
                        defaultTextStyle: Styles.KiziContent,
                        showImages: true
                    )
                ],
            )
        );
    }
}

// https://www.jianshu.com/p/f87044ebe9e7