class KiziListItem {

    KiziListItem({this.title, this.arasuzi, this.url, this.date});

    String title;
    String arasuzi;
    String url;
    String date;

    @override
    String toString() {
        return "$title|$date|$arasuzi|$url";
    }
}