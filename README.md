# NNS_Android
+ Developed by [Flutter](https://flutter.dev/) framework

### Environment
+ `Flutter 1.5.4-hotfix.2`
+ `Dart 2.3.0`
+ `VS Code`
+ (`AS 3.3.x`)

### Build & Run
```bash
flutter packages get # Get dependencies from pubspec

set http_proxy=127.0.0.1:1080
set https_proxy=127.0.0.1:1080 # Add proxy for terminal

adb connect 127.0.0.1:xxxxx # Connect adb server
flutter run # Run App through adb
```

### [Dependencies](https://github.com/Aoi-hosizora/NNS_Android/blob/master/pubspec.yaml)
```yaml
cupertino_icons: ^0.1.2
fluttertoast: ^2.1.1
url_launcher: ^5.0.2
http: ^0.12.0+2
html: ^0.14.0+2
sprintf: ^4.0.2
flutter_staggered_grid_view: "^0.2.7"
```