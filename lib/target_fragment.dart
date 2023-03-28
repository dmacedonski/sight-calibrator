import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("New target")),
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
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _sizeController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        labelText: "Diameter of the target (inches)",
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
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Target target = Target.create(_nameController.text,
                            double.parse(_sizeController.text));
                        await widget.targetDao.insertOne(target);
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
