import 'dart:collection';

import './Lists/GrammarListItem.dart';
import './Lists/KiziListItem.dart';

class OnlineListDataMgr {

    static OnlineListDataMgr _instance;
    OnlineListDataMgr._();

    static OnlineListDataMgr getInstance() {
        if (_instance == null)
            _instance = OnlineListDataMgr._();
        return _instance;
    }

    /// 中国での生活 Kizi List
    List<KiziListItem> seikatuKizis = <KiziListItem>[];
    /// 中国での生活 refresh Cnt
    int seikatuKiziCnt = 0;

    /// 日本語教師のお仕事 Kizi list
    List<KiziListItem> shikotoKizis = <KiziListItem>[];
    /// 日本語教師のお仕事 refresh Cnt
    int shikotoKiziCnt = 0;

    /// 文法講座 item list
    var grammarLists = HashMap<String, List<GrammarListItem>>();
}