import 'package:flutter/material.dart';

class KiziListItem {

    KiziListItem({@required this.type, this.title, this.arasuzi, this.url, this.date});

    String title;
    String arasuzi;
    String url;
    String date;
    
    String type;

    @override
    String toString() {
        return "$type|$title|$date|$arasuzi|$url";
    }
}