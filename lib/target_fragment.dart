import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sight_calibrator/data/target.dart';

class TargetFragment extends StatefulWidget {
  final TargetDao targetDao;

  const TargetFragment({super.key, required this.targetDao});

  @override
  State<TargetFragment> createState() => _TargetFragmentState();
}

class _TargetFragmentState extends State<TargetFragment> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();
  final _distanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.newTarget)),
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
                    controller: _sizeController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.diameterOfTheTarget,
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
                    controller: _distanceController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.distanceToTarget,
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
                        Target target = Target.create(
                            _nameController.text,
                            double.parse(_sizeController.text),
                            double.parse(_distanceController.text));
                        await widget.targetDao.insertOne(target);
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
