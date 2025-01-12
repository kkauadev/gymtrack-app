import 'package:flutter/material.dart';
import 'package:gymtrack/routing/router.dart';
import 'package:gymtrack/ui/core/themes/theme.dart';
import 'package:provider/provider.dart';
import 'config/dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: providersRemote,
      //ChangeNotifierProvider(create: (_) => SomeProvider()),
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: router(),
      ),
    ),
  );
}
