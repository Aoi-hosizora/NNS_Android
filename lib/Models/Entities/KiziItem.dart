import '../Lists/KiziListItem.dart';
import './KiziType.dart';

class KiziItem extends KiziListItem {

    KiziItem(this.type, {this.title, this.content, this.url, this.date}) : super();

    String title;
    String content;
    String url;
    String date;

    KiziType type;

    @override
    String toString() {
        return "$title|$date|$content|$url";
    }
}