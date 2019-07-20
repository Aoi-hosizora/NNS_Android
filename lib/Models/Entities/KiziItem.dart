import 'package:nihongo_no_sensei/Models/Lists/KiziListItem.dart';

class KiziItem {

    KiziItem({this.type, this.title, this.content, this.url, this.date});

    KiziItem.fromList({KiziListItem kizi}) : this(
        type: kizi.type, title: kizi.title, content: kizi.arasuzi, url: kizi.url, date: kizi.date
    );

    String title;
    String content;
    String url;
    String date;

    String type;

    @override
    String toString() {
        return "$title|$date|$content|$url";
    }
}