import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({super.key});

  @override
  State<StatefulWidget> createState() => AppInfoState();
}

class AppInfoState extends State<AppInfo> {
  String _version = "";

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60, bottom: 20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _version,
            style: TextStyle(color: Color(0xFFAAAAAA)),
          )
        ],
      ),
    );
  }
}
