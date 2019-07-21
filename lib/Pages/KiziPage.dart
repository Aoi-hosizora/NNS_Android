import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Models/Lists/KiziListItem.dart';
import '../Models/Entities/KiziItem.dart';
import '../Constants/Strings.dart';
import '../Constants/Styles.dart';
import '../Constants/Dimens.dart';
import '../Utils/CommonUtil.dart';
import '../Utils/NetUtil.dart';

class KiziPage extends StatefulWidget {

    KiziPage({@required this.kizi, Key key}) : super(key: key);

    final KiziListItem kizi;

    @override
    State<KiziPage> createState() => new _KiziPageState(kizi: kizi);
}

class _KiziPageState extends State<KiziPage> {

    _KiziPageState({@required this.kizi});

    KiziListItem kizi;
    KiziItem _kiziItem;

    @override
    void initState() {
        super.initState();
        _kiziItem = KiziItem.fromList(kizi: kizi);
        WidgetsBinding.instance.addPostFrameCallback((callback) {
            _getData();
        });
    }

    /// get Kizi Content data from net
    Future<void> _getData() async {
        CommonUtil.showProgress(context: context, message: Text(Strings.Loading, style: Styles.NormalTextStyle), barrierDismissible: false);
        _kiziItem = await NetUtil.getKiziContent(kizi);
        CommonUtil.loge("getData", "_kiziItem: " + _kiziItem.content.length.toString());
        Navigator.of(context).pop();
        setState(() {});
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(Strings.KiziPageTitle, style: Styles.NormalTextStyle),
                actions: <Widget>[
                    IconButton(
                        tooltip: Strings.OpenWebSiteToolBar,
                        icon: Icon(Icons.web),
                        onPressed: () => CommonUtil.openBrowser(_kiziItem.url),
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
                        child: Text(_kiziItem.title, style: Styles.KiziTitle)
                    ),
                    Text(_kiziItem.type, style: Styles.KiziSubTitle, textAlign: TextAlign.end),
                    Text(_kiziItem.date, style: Styles.KiziSubTitle, textAlign: TextAlign.end),
                    Divider(),
                    // Text(_kiziItem.content),
                    Html(
                        data: _kiziItem.content,
                        padding: EdgeInsets.all(Dimens.HTMLPadding),
                        defaultTextStyle: Styles.KiziContent,
                        showImages: true,
                        onImageTap: (img) => CommonUtil.showToast(img),
                        onLinkTap: (url) => CommonUtil.openBrowser(url)
                    )
                ]
            ),
        );
    }
}