import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sight_calibrator/app_settings.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({super.key});

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  final _formKey = GlobalKey<FormState>();
  final _appSettings = AppSettings.getInstance();

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> languages = <DropdownMenuItem>[];
    languages.add(DropdownMenuItem(
        value: null, child: Text(AppLocalizations.of(context)!.system)));
    for (Locale locale in AppLocalizations.supportedLocales) {
      var languageName = locale.languageCode;
      switch (locale.languageCode) {
        case "en":
          languageName = "English";
          break;
        case "pl":
          languageName = "Polski";
          break;
      }
      languages.add(DropdownMenuItem(value: locale, child: Text(languageName)));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.theme,
                      border: const OutlineInputBorder(),
                      helperText: ""),
                  value: _appSettings.themeMode,
                  items: [
                    DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text(AppLocalizations.of(context)!.system)),
                    DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(AppLocalizations.of(context)!.light)),
                    DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(AppLocalizations.of(context)!.dark))
                  ],
                  onChanged: (themeMode) async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .settingsHasBeenChanged)),
                    );
                    setState(() {
                      _appSettings.themeMode = themeMode ?? ThemeMode.system;
                      _appSettings.save();
                    });
                  }),
              const SizedBox(height: 6),
              DropdownButtonFormField(
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.language,
                      border: const OutlineInputBorder(),
                      helperText: ""),
                  value: _appSettings.locale,
                  items: languages,
                  onChanged: (locale) async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .settingsHasBeenChanged)),
                    );
                    setState(() {
                      _appSettings.locale = locale;
                      _appSettings.save();
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
