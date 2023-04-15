import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sight_calibrator/data/app_database.dart';
import 'package:sight_calibrator/scopes_fragment.dart';
import 'package:sight_calibrator/session_fragment.dart';
import 'package:sight_calibrator/settings_fragment.dart';
import 'package:sight_calibrator/targets_fragment.dart';

class MainActivity extends StatefulWidget {
  final AppDatabase db;
  final CameraDescription camera;

  const MainActivity({super.key, required this.db, required this.camera});

  @override
  State<StatefulWidget> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int _selectedFragmentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sight Calibrator"),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                value: 0,
                child: Row(children: [
                  const Icon(Icons.settings_rounded),
                  const SizedBox(width: 12),
                  Text(AppLocalizations.of(context)!.settings)
                ]),
              )
            ],
            onSelected: (selectedItem) {
              switch (selectedItem) {
                case 0:
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsFragment()));
                  break;
              }
            },
          )
        ],
      ),
      body: <Widget>[
        SessionFragment(
            scopeDao: widget.db.scopeDao,
            targetDao: widget.db.targetDao,
            camera: widget.camera),
        ScopesFragment(scopeDao: widget.db.scopeDao),
        TargetsFragment(targetDao: widget.db.targetDao)
      ][_selectedFragmentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: <Widget>[
          NavigationDestination(
              icon: const Icon(Icons.grain_rounded),
              label: AppLocalizations.of(context)!.session),
          NavigationDestination(
              icon: const Icon(Icons.location_searching_rounded),
              label: AppLocalizations.of(context)!.scopes),
          NavigationDestination(
              icon: const Icon(Icons.radio_button_checked_rounded),
              label: AppLocalizations.of(context)!.targets),
        ],
        selectedIndex: _selectedFragmentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedFragmentIndex = index;
          });
        },
      ),
    );
  }
}
