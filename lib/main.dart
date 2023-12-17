import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme_service.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeService>(
    create: (context) => ThemeService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
        builder: (context, ThemeService themeService, widget) {
      return MaterialApp(
        themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeService.lightTheme,
      );
    });
  }
}
