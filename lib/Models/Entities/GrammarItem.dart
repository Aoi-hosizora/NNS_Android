import 'package:nihongo_no_sensei/Models/Lists/GrammarListItem.dart';

class GrammarItem {

    GrammarItem({this.title, this.content, this.url, this.grammarClass}) : super();

    GrammarItem.fromList({GrammarListItem gmr}) : this(
        title: gmr.title, url: gmr.url, content: "", grammarClass: gmr.grammarClass
    );

    String title;
    String content;
    String url;

    String grammarClass;

    @override
    String toString() {
        return "$title|$content|$url";
    }
}