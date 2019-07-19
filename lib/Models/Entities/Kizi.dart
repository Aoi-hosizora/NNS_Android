class Kizi {

    Kizi({this.title, this.content, this.url, this.date});

    String title;
    String content;
    String url;
    String date;

    @override
    String toString() {
        return "$title|$date|$content|$url";
    }
}