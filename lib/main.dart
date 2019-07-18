import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';

import 'Constants/Strings.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            locale: Locale("ja", "JP"),
            title: Strings.AppTitle,
            theme: ThemeData(
                primarySwatch: Colors.blue
            ),
            home: HomePage(),
        );
    }
}

