import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  decoration: const InputDecoration(
                      labelText: "Theme",
                      border: OutlineInputBorder(),
                      helperText: ""),
                  value: _appSettings.themeMode,
                  items: const [
                    DropdownMenuItem(
                        value: ThemeMode.system, child: Text("System")),
                    DropdownMenuItem(
                        value: ThemeMode.light, child: Text("Light")),
                    DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark"))
                  ],
                  onChanged: (themeMode) async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Settings has been changed.")),
                    );
                    setState(() {
                      _appSettings.themeMode = themeMode ?? ThemeMode.system;
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
