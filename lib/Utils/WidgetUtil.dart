import 'dart:collection';

import 'package:flutter/material.dart';

import '../Constants/Strings.dart';
import '../Constants/Consts.dart';
import '../Constants/Styles.dart';
import '../Constants/Dimens.dart';
import '../Models/Lists/KiziListItem.dart';
import '../Models/Lists/GrammarListItem.dart';

class WidgetUtil {
    WidgetUtil._();

    /// KiziListItem(4) -> Card(3)
    static Card getCardFromKiziListItem(KiziListItem kizi, void onTap()) =>
        Card(
            child: ListTile(
                title: Text(
                    kizi.title,
                    style: Styles.TitleTextStyle, 
                    maxLines: Consts.CardTitleMaxLine, overflow: TextOverflow.ellipsis
                ),
                subtitle: Column(
                    children: <Widget>[
                        Text(
                            kizi.date, 
                            style: Styles.SubTitleTextStyle,
                            textAlign: TextAlign.left,
                        ),
                        Text(
                            kizi.arasuzi, 
                            style: Styles.SubTitleTextStyle, 
                            maxLines: Consts.CardSubTitleMaxLine, overflow: TextOverflow.ellipsis
                        ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                ),
                onTap: onTap,
            )
        );

    /// GrammarListItem(2) -> ListTile(1)
    static ListTile getListTileFromGrammarListItem(GrammarListItem gm, void onTap()) =>
         ListTile(
                title: Text(gm.title, style: Styles.TitleTextStyle),
                onTap: onTap
            );

    /// More Card(ListTile)
    static Card getMoreCard({void onTap()}) =>
        Card(
            child: getMoreTile(onTap: onTap)
        );
    
    /// More ListTile
    static ListTile getMoreTile({void onTap()}) =>
        ListTile(
            title: Center(child: Text(Strings.More, style: Styles.TitleTextStyle)),
            onTap: () => onTap(),
        );

    /// Loading Card(ListTile)
    static Card getLoadingCard() =>
        Card(
            child: getLoadingTile()
        );

    /// Loading ListTile
    static ListTile getLoadingTile() => 
        ListTile(
            title: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: Dimens.KiziCircularProgressStrokeWidth,
                    ),
            ),
            onTap: () {},
        );

    /// add loading remove More
    static List<Widget> addLoadingRemoveAdd(List<Widget> list, {Card load, Card more}) {
        var ret = <Widget>[];
        ret.addAll(list);
        ret.remove(more);
        ret.add(load);
        return ret;
    }

    /// List<ListTile>(gmrs + more) -> Card
    static Card getCompleteGrammarClassCardFromHashMap(String grammarClass, {HashMap<String, List<ListTile>> gmrslists, HashMap<String, ListTile> morelists}) {
        List<Widget> list = <Widget>[
            Padding(
                child: Center(
                    child: Text(grammarClass, style: Styles.NormalTextStyle)
                ),
                padding: EdgeInsets.all(Dimens.GrammarTitleListTilePadding)
            )
        ];

        if (gmrslists != null && gmrslists[grammarClass] != null) {
            list.add(Divider());
            for (var gc in gmrslists[grammarClass]) {
                list.add(gc);
                list.add(Divider());
            }
            if (morelists != null)
                list.add(morelists[grammarClass]);
            else
                list.removeLast(); // Last divider
        }

        return Card(
            child: Column(
                children: list
            )
        );
    }
}