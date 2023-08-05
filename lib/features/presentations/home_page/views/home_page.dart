import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(),
    );
  }
}

_appBar() {
  return AppBar(
    leading: GestureDetector(
      onTap: () {},
      child: const Icon(
        Icons.nightlight_round,
        size: 20,
      ),
    ),
    actions: const [
      Icon(
        Icons.person,
        size: 20,
      ),
      SizedBox(
        width: 20,
      )
    ],
  );
}
