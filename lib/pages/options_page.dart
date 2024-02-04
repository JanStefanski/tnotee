import 'package:tnotee/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  _OptionsPageState createState() => _OptionsPageState();
}

// lib/pages/options_page.dart
class _OptionsPageState extends State<OptionsPage> {
  String dropdownValue = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.options)
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: NoteApp.of(context).themeMode == ThemeMode.dark,
            onChanged: (value) {
              final themeMode = value ? ThemeMode.dark : ThemeMode.light;
              NoteApp.of(context).toggleTheme();
              SharedPreferences.getInstance().then((prefs) {
                prefs.setBool('darkMode', value);
              });
              setState(() {});
            },
            title: Text(AppLocalizations.of(context)!.darkMode),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.language),
            trailing: DropdownMenu(
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'en', label: 'English'),
                DropdownMenuEntry(value: 'pl', label: 'Polski'),
                DropdownMenuEntry(value: 'de', label: 'Deutsch'),
                DropdownMenuEntry(value: 'fr', label: 'Français'),
                DropdownMenuEntry(value: 'sv', label: 'Svenska'),
                DropdownMenuEntry(value: 'cs', label: 'Čeština'),
                DropdownMenuEntry(value: 'sk', label: 'Slovenčina'),
                DropdownMenuEntry(value: 'hu', label: 'Magyar'),
                DropdownMenuEntry(value: 'fi', label: 'Suomi'),
                DropdownMenuEntry(value: 'no', label: 'Norsk'),
                DropdownMenuEntry(value: 'es', label: 'Español'),
                DropdownMenuEntry(value: 'it', label: 'Italiano'),
                DropdownMenuEntry(value: 'nl', label: 'Nederlands'),
                DropdownMenuEntry(value: 'pt', label: 'Português'),
                DropdownMenuEntry(value: 'ro', label: 'Română'),
                DropdownMenuEntry(value: 'el', label: 'Ελληνικά'),
                DropdownMenuEntry(value: 'bg', label: 'Български'),
                DropdownMenuEntry(value: 'hr', label: 'Hrvatski'),
                DropdownMenuEntry(value: 'da', label: 'Dansk'),
                DropdownMenuEntry(value: 'et', label: 'Eesti'),
                DropdownMenuEntry(value: 'lv', label: 'Latviešu'),
                DropdownMenuEntry(value: 'lt', label: 'Lietuvių'),
                DropdownMenuEntry(value: 'sl', label: 'Slovenščina'),
                DropdownMenuEntry(value: 'ja', label: '日本語'),
                DropdownMenuEntry(value: 'zh', label: '繁體中文'),
                DropdownMenuEntry(value: 'vi', label: 'Tiếng Việt'),
                DropdownMenuEntry(value: 'hi', label: 'हिन्दी'),
                DropdownMenuEntry(value: 'uk', label: 'Українська'),
                DropdownMenuEntry(value: 'ar', label: 'العربية'),
              ],
              initialSelection: Localizations.localeOf(context).languageCode,
              onSelected: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setString('locale', dropdownValue);
                  });
                  NoteApp.of(context).setLocale(Locale(dropdownValue));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}