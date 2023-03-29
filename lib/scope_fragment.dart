import 'package:flutter/material.dart';
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
        appBar: AppBar(title: const Text("New scope")),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: "Name", border: OutlineInputBorder()),
                    maxLength: 50,
                    maxLines: 1,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Field is required.";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _inchesPerClickController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: "Inches per click",
                        border: OutlineInputBorder(),
                        helperText: ""),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Field is required.";
                      }
                      if (!RegExp(r"^(\d+\.)?\d+$").hasMatch(value)) {
                        return "Invalid number.";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _forDistanceController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        labelText: "For distance (yards)",
                        border: OutlineInputBorder(),
                        helperText: ""),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Field is required.";
                      }
                      if (!RegExp(r"^(\d+\.)?\d+$").hasMatch(value)) {
                        return "Invalid number.";
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
                    label: const Text("Save"),
                  )
                ],
              ),
            )));
  }
}
