class GrammarListItem {

    GrammarListItem({this.title, this.url, this.grammarClass});

    String title;
    String url;

    String grammarClass;

    @override
    String toString() {
        return "$title|$url";
    }
}