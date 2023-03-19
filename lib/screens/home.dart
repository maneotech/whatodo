import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/components/activity_container.dart';
import 'package:whatodo/constants/constant.dart';
import 'package:whatodo/repositories/shared_pref.dart';

import '../providers/auth.dart';
import '../services/base_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextButton(
        child: Text("Se déconnecter"),
        onPressed: () => disconnect(),
      ),
      Text("Hello John! Enjoy your"),
      const Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Text("new adventure"),
      ),
      Expanded(
        child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: [
              ActivityContainer(),
              ActivityContainer(),
              ActivityContainer(),
              ActivityContainer(),
              ActivityContainer(),
              ActivityContainer()
            ]),
      ),
      TextButton(onPressed: () => test(), child: Text("TESTER"))
    ]);
  }

  test() async {
    try {
      var res = await BaseAPI.findPlaces();
      var body = res.body;
      print(res.body);
      print(res);
    } catch (e) {
      print(e);
    }
  }

  disconnect() async {
    await Provider.of<AuthProvider>(context, listen: false).logout();
  }
}
