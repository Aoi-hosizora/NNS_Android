import '../../Constants/Strings.dart';

class GrammarListItem {

    GrammarListItem({this.title, this.url});

    String title;
    String url;

    @override
    String toString() {
        return "$title|$url";
    }

    static const String N1 = Strings.GrammarClassN1;
    static const String N1W = Strings.GrammarClassN1W;
    static const String N2 = Strings.GrammarClassN2;
    static const String N3 = Strings.GrammarClassN3;
    static const String N45 = Strings.GrammarClassN45;
    static const String N0 = Strings.GrammarClassN0;
}