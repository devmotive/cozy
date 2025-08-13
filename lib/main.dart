import 'package:cozy/models/space.dart';
import 'package:cozy/pages/detail_page.dart';
import 'package:cozy/pages/home_page.dart';
import 'package:cozy/pages/started_page.dart';
import 'package:cozy/providers/recommended_space_provider.dart';
import 'package:cozy/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecommendedSpaceProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      routes: {
        StartedPage.routeName: (context) => StartedPage(),
        HomePage.routeName: (context) => HomePage(),
        DetailPage.routeName: (context) => DetailPage(
          space: ModalRoute.of(context)?.settings.arguments as Space,
        ),
      },
    );
  }
}
