import 'package:flutter/material.dart';
import 'package:jym_app/core/utils/theme/theme.dart';
import 'package:jym_app/features/presentations/home_page/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}
