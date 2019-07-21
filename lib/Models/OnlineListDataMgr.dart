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
    /// 中国での生活 clear
    void initSeikakuKizis() {
        seikatuKiziCnt = 0;
        seikatuKizis.clear();
    }

    /// 日本語教師のお仕事 Kizi list
    List<KiziListItem> shigotoKizis = <KiziListItem>[];
    /// 日本語教師のお仕事 refresh Cnt
    int shigotoKiziCnt = 0;
    /// 日本語教師のお仕事 clear
    void initShigotoKizis() {
        shigotoKiziCnt = 0;
        shigotoKizis.clear();
    }

    /// 文法講座 item list
    var grammarLists = HashMap<String, List<GrammarListItem>>();
}