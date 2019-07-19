import 'package:flutter/material.dart';

class Styles {
    Styles._();

    /// Japanese Font Text Style: `Locale("ja", "JP")`
    static const NormalTextStyle = const TextStyle(locale: Locale("ja", "JP"));

    /// Grey Text Style: `Colors.grey`
    static const GrayTextStyle = const TextStyle(locale: Locale("ja", "JP"), color: Colors.grey);

    /// Grey Text Style: `Colors.grey`
    static const TitleTextStyle = const TextStyle(locale: Locale("ja", "JP"), color: Colors.black, fontSize: 15);

    static const SubTitleTextStyle = const TextStyle(locale: Locale("ja", "JP"), color: Colors.grey, fontSize: 12);
}