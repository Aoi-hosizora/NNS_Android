class GrammarListItem {

    GrammarListItem({this.title, this.url});

    String title;
    String url;

    @override
    String toString() {
        return "$title|$url";
    }
}