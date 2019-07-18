import 'package:flutter/material.dart';

import '../Utils/CommonUtil.dart';
import '../Constants/Strings.dart';

class HomePage extends StatefulWidget {
	
	final String title = Strings.HomePageTitle;

	HomePage({Key key}) : super(key: key);
	
	@override
	State<HomePage> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
    
    int _counter = 1;

    void _incrementCounter() {
        setState(() => _counter *= 2);
        CommonUtil.showToast(_counter);
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title, style: TextStyle(locale: Locale("ja", "JP"))),
                actions: <Widget>[
                    IconButton(
                        tooltip: "Test",
                        icon: Icon(Icons.menu),
                        onPressed: () => CommonUtil.showToast("Test"),
                    )
                ],
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text('You have pushed the button this many times:'),
                        Text('$_counter', style: Theme.of(context).textTheme.display1)
                    ]
                )
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.add)
            )
        );
    }
}
