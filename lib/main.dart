import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_mode_provider/providers/theme_provider.dart';
import 'package:theme_mode_provider/screens/first_screen.dart';
import 'package:theme_mode_provider/utils/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? true;
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (ctx) =>
                ThemeNotifier(darkModeOn ? darkTheme : lightTheme)),
      ],
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      title: 'Flutter Theme Mode',
      home: const HomepageScreen(),
    );
    // });
  }
}
