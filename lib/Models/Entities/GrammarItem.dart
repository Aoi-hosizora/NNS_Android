class GrammarItem {

    GrammarItem({this.title, this.content, this.url}) : super();

    String title;
    String content;
    String url;

    @override
    String toString() {
        return "$title|$content|$url";
    }
}