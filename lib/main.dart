// main.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tnotee/pages/note_list_page.dart';
import 'package:tnotee/helpers/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(NoteApp());
}

class NoteApp extends StatefulWidget {
  @override
  _NoteAppState createState() => _NoteAppState();

  static _NoteAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_NoteAppState>()!;
  }
}


class _NoteAppState extends State<NoteApp> {
  ThemeMode themeMode = ThemeMode.system;
  Locale _locale = PlatformDispatcher.instance.locale;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final darkModeOn = prefs.getBool('darkMode') ?? false;
      final locale = prefs.getString('locale');
      setState(() {
        themeMode = darkModeOn ? ThemeMode.dark : ThemeMode.light;
        _locale = locale != null ? Locale(locale) : _locale;
      });
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tnotee',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: _locale,
      home: const NoteListPage(),
      onGenerateRoute: generateRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  void toggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }
}
