import 'package:cozy/pages/started_page.dart';
import 'package:cozy/theme/theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      routes: {StartedPage.routeName: (context) => StartedPage()},
    );
  }
}
