import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Map<Permission, PermissionStatus> stats = new Map();
  late Map<Permission, String> statsName = {
    Permission.storage: 'File System',
    Permission.camera: 'Camera',
    Permission.location: 'Location',
    Permission.bluetooth: 'Bluetooth',
    Permission.sms: 'SMS',
    Permission.microphone: 'Voice Input',
    Permission.notification: 'Notifications',
  };

  Future<void> getPerms() async {
    // You can request multiple permissions at once.

    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.location,
      Permission.bluetooth,
      Permission.sms,
      Permission.microphone,
      Permission.notification
    ].request();

    setState(() {
      stats = statuses;
    });

    print(stats[Permission.location]);
  }

  @override
  void initState() {
    getPerms().then((value) => {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...stats.entries.toList().map((e) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(statsName[e.key]!),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      e.value.isGranted ? Icons.check_circle : Icons.dangerous,
                      color: e.value.isGranted ? Colors.green : Colors.red,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
