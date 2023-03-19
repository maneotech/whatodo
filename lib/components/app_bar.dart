import 'package:flutter/material.dart';

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  final bool enableBackIcon;
  final bool isCustomPage;
  const AppBarComponent(
      {super.key, this.enableBackIcon = false, this.isCustomPage = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {




  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: const Text("Title"),
      leading: const Icon(Icons.token),
    );
  }
}
