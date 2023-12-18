import 'package:advicer_app/application/core/services/theme_service.dart';
import 'package:advicer_app/application/pages/advice/advice_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

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
        theme:
            themeService.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
        home: const AdviserPageWrapper(),
      );
    });
  }
}
