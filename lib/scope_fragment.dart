import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sight_calibrator/data/scope.dart';

class ScopeFragment extends StatefulWidget {
  final ScopeDao scopeDao;

  const ScopeFragment({super.key, required this.scopeDao});

  @override
  State<ScopeFragment> createState() => _ScopeFragmentState();
}

class _ScopeFragmentState extends State<ScopeFragment> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _inchesPerClickController = TextEditingController();
  final _forDistanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.newScope)),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.name,
                        border: const OutlineInputBorder()),
                    maxLength: 50,
                    maxLines: 1,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.fieldIsRequired;
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _inchesPerClickController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.inchesPerClick,
                        border: const OutlineInputBorder(),
                        helperText: ""),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.fieldIsRequired;
                      }
                      if (!RegExp(r"^(\d+\.)?\d+$").hasMatch(value)) {
                        return AppLocalizations.of(context)!.invalidNumber;
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _forDistanceController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.forDistance,
                        border: const OutlineInputBorder(),
                        helperText: ""),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.fieldIsRequired;
                      }
                      if (!RegExp(r"^(\d+\.)?\d+$").hasMatch(value)) {
                        return AppLocalizations.of(context)!.invalidNumber;
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Scope scope = Scope.create(
                            _nameController.text,
                            double.parse(_inchesPerClickController.text),
                            double.parse(_forDistanceController.text));
                        await widget.scopeDao.insertOne(scope);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.done),
                    label: Text(AppLocalizations.of(context)!.save),
                  )
                ],
              ),
            )));
  }
}
