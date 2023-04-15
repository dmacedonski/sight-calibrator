import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sight_calibrator/data/scope.dart';
import 'package:sight_calibrator/data/target.dart';
import 'package:sight_calibrator/mark_hits_fragment.dart';

class SessionFragment extends StatefulWidget {
  final ScopeDao scopeDao;
  final TargetDao targetDao;
  final CameraDescription camera;

  const SessionFragment(
      {super.key,
      required this.scopeDao,
      required this.targetDao,
      required this.camera});

  @override
  State<StatefulWidget> createState() => _SessionFragmentState();
}

class _SessionFragmentState extends State<SessionFragment> {
  final _formKey = GlobalKey<FormState>();
  Scope? _selectedScope;
  Target? _selectedTarget;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: widget.scopeDao.findAll(),
          builder: (_, scopesSnapshot) {
            if (!scopesSnapshot.hasData) {
              return Container();
            }
            return StreamBuilder(
              stream: widget.targetDao.findAll(),
              builder: (_, targetsSnapshot) {
                if (!targetsSnapshot.hasData) {
                  return Container();
                }
                final scopes = scopesSnapshot.requireData;
                final targets = targetsSnapshot.requireData;
                if (scopes.isEmpty || targets.isEmpty) {
                  return _buildHelp(context);
                }
                _selectedScope = scopes.first;
                _selectedTarget = targets.first;
                return _buildForm(context, scopes, targets);
              },
            );
          },
        ));
  }

  Widget _buildHelp(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("To start session you must:"),
        Text("1. Add some scope."),
        Text("2. Add some target."),
        Text("3. Select scope and target on this screen."),
        Text("4. Shoot a few times to target."),
        Text("5. Shoot a few times to target."),
        Text("6. Click \"start calibration\"."),
        Text("7. Point the camera at the target and mark the hits."),
        Text("8. Click \"show result\"."),
        Text("9. Calibrate your scope."),
        Text("10. Repeat steps 4 - 9 if needed."),
      ],
    );
  }

  Widget _buildForm(
      BuildContext context, List<Scope> scopes, List<Target> targets) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            icon: const Icon(Icons.arrow_drop_down_rounded),
            decoration: const InputDecoration(
                labelText: "Scope",
                border: OutlineInputBorder(),
                helperText: ""),
            value: _selectedScope,
            items: scopes
                .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                .toList(),
            onChanged: (scope) {
              setState(() {
                _selectedScope = scope;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (Scope? scope) {
              if (scope == null) {
                return "Field is required.";
              }
              return null;
            },
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField(
            icon: const Icon(Icons.arrow_drop_down_rounded),
            decoration: const InputDecoration(
                labelText: "Target",
                border: OutlineInputBorder(),
                helperText: ""),
            value: _selectedTarget,
            items: targets
                .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                .toList(),
            onChanged: (target) {
              setState(() {
                _selectedTarget = target;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (Target? target) {
              if (target == null) {
                return "Field is required.";
              }
              return null;
            },
          ),
          const SizedBox(height: 6),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MarkHitsFragment(
                        camera: widget.camera,
                        scope: _selectedScope!,
                        target: _selectedTarget!)));
              }
            },
            child: const Text("Start calibration"),
          )
        ],
      ),
    );
  }
}
