import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/components/action_button.dart';

import '../components/app_bar.dart';
import '../providers/auth.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: Column(
        children: [
          ActionButton(
            title: "Se déconnecter",
            onTap: () => disconnect(context),
          )
        ],
      ),
    );
  }

  disconnect(BuildContext context) async {
    await Provider.of<AuthProvider>(context, listen: false).logout();
  }
}
