import '../Constants/Strings.dart';

class Consts {
    Consts._();

    /// PageCnt in one refresh `2`
    static const int KiziPagesForOneRefresh = 2;
    /// ItemCnt in one page(determined by website) `3`
    static const int KiziItemsForOnePage = 3;

    /// CardView title maxLines `1`
    static const int CardTitleMaxLine = 1;
    /// CardView title maxLines `3`
    static const int CardSubTitleMaxLine = 3;

    /// GrammarList mininum cnt `3`
    static const int GrammarListMinCnt = 3;

    static const List<String> GrammarClass = <String>[N1, N1W, N2, N3, N45, N0];
    
    static const String N1 = Strings.GrammarClassN1;
    static const String N1W = Strings.GrammarClassN1W;
    static const String N2 = Strings.GrammarClassN2;
    static const String N3 = Strings.GrammarClassN3;
    static const String N45 = Strings.GrammarClassN45;
    static const String N0 = Strings.GrammarClassN0;

    static const String TSeikatu = Strings.KiziTypeSeikatu;
    static const String TShitoko = Strings.KiziTypeShigoto;

    /// RefreshIndicator onRefresh Future Delay `1s`
    static const Duration RefreshTime = Duration(seconds: 1);
    /// Open new page wait to get data `200ms`
    static const Duration WaitingGetDataTime = Duration(milliseconds: 200);
}