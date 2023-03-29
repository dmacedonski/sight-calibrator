import 'package:flutter/material.dart';
import 'package:sight_calibrator/data/scope.dart';
import 'package:sight_calibrator/data/target.dart';

class SessionFragment extends StatefulWidget {
  final ScopeDao scopeDao;
  final TargetDao targetDao;

  const SessionFragment(
      {super.key, required this.scopeDao, required this.targetDao});

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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder(
          stream: widget.scopeDao.findAll(),
          builder: (_, scopesSnapshot) {
            return StreamBuilder(
              stream: widget.targetDao.findAll(),
              builder: (_, targetsSnapshot) {
                if (!scopesSnapshot.hasData || !targetsSnapshot.hasData) {
                  return Container();
                }
                final scopes = scopesSnapshot.requireData;
                final targets = targetsSnapshot.requireData;
                if (scopes.isEmpty || targets.isEmpty) {
                  return _buildHelp(context);
                }
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
            value: scopes.first,
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
            value: targets.first,
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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("TODO: Go to marking hits screen."),
                  duration: Duration(seconds: 10),
                ));
              }
            },
            child: const Text("Start calibration"),
          )
        ],
      ),
    );
  }
}
