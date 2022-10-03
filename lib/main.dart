import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int iconIndex = 0;

  List iconName = <String>['icon1', 'icon2', 'icon3'];

  List<String> imagefiles = [
    "images/1.png",
    "images/2.png",
    "images/3.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildIconTile(0, 'Whatsapp'),
              buildIconTile(1, 'Instagram'),
              buildIconTile(2, 'Linkdin'),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () => changeAppIcon(),
                  child: const Text('Set as app icon')),
            ],
          )),
    );
  }

  Widget buildIconTile(int index, String themeTxt) => Padding(
        padding: const EdgeInsets.all(20 / 2),
        child: GestureDetector(
          onTap: () => setState(() => iconIndex = index),
          child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
              leading: Image.asset(
                imagefiles[index],
                width: 45,
                height: 45,
              ),
              title: Text(themeTxt, style: const TextStyle(fontSize: 25)),
              trailing: iconIndex == index
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 30,
                    )
                  : Icon(
                      Icons.circle_outlined,
                      color: Colors.grey.withOpacity(0.5),
                      size: 30,
                    )),
        ),
      );

  changeAppIcon() async {
    try {
      if (await FlutterDynamicIcon.supportsAlternateIcons) {
        await FlutterDynamicIcon.setAlternateIconName(iconName[iconIndex]);
        debugPrint("App icon change successful");
        return;
      }
    } catch (e) {
      debugPrint("Exception: ${e.toString()}");
    }
    debugPrint("Failed to change app icon ");
  }
}
