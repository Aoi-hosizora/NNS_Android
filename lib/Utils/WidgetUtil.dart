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

    static Card getCardFromKiziListItem(KiziListItem kizi, void onTap()) =>
        Card(
            child: ListTile(
                title: Text(
                    kizi.title,
                    style: Styles.TitleTextStyle, 
                    maxLines: Consts.CardTitleMaxLine, overflow: TextOverflow.ellipsis
                ),
                subtitle: Text(
                    kizi.arasuzi, 
                    style: Styles.SubTitleTextStyle, 
                    maxLines: Consts.CardSubTitleMaxLine, overflow: TextOverflow.ellipsis
                ),
                trailing: Text(
                    kizi.date, 
                    style: Styles.SubTitleTextStyle
                ),
                onTap: onTap,
            )
        );

    static Card getCardFromGrammarListItem(GrammarListItem gm, void onTap()) =>
        Card(
            child: ListTile(
                title: Text(gm.title, style: Styles.TitleTextStyle),
                onTap: onTap
            )
        );  

    static Card getMore(void onTap()) =>
        Card(
            child: ListTile(
                title: Center(child: Text(Strings.More, style: Styles.TitleTextStyle)),
                onTap: () => onTap(),
            ),
        );

    static ListView getCompleteGrammarListViewFromHashMap(HashMap<String, List<Card>> cardlists, HashMap<String, Card> mores, String grammarClass) {
        List<Widget> list = <Widget>[
            Text(grammarClass, style: Styles.NormalTextStyle)
        ];

        if (cardlists != null && cardlists[grammarClass] != null)
            list.addAll(cardlists[grammarClass]);

        list.add(mores[grammarClass]);

        return ListView(
            children: list
        );
    }
}