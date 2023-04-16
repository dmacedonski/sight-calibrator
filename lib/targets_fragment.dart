import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sight_calibrator/target_fragment.dart';

import 'data/target.dart';

class TargetsFragment extends StatefulWidget {
  final TargetDao targetDao;

  const TargetsFragment({super.key, required this.targetDao});

  @override
  State<TargetsFragment> createState() => _TargetsFragmentState();
}

class _TargetsFragmentState extends State<TargetsFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Target>>(
        stream: widget.targetDao.findAll(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              alignment: Alignment.topCenter,
              child: Text(AppLocalizations.of(context)!.emptyTargetsList),
            );
          }
          final targets = snapshot.requireData;
          if (targets.isEmpty) {
            return Container(
              alignment: Alignment.topCenter,
              child: Text(AppLocalizations.of(context)!.emptyTargetsList),
            );
          }
          return ListView.builder(
              itemCount: targets.length,
              itemBuilder: (_, index) {
                return Dismissible(
                    key: Key(index.toString()),
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.redAccent,
                      child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Icon(Icons.delete, color: Colors.white)),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) async {
                      await widget.targetDao.deleteOne(targets[index]);
                    },
                    child: ListTile(
                        title: Text(targets[index].name),
                        subtitle: Text(AppLocalizations.of(context)!
                            .targetDescription(targets[index].distance,
                                targets[index].size))));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TargetFragment(targetDao: widget.targetDao)));
          },
          child: const Icon(Icons.add_rounded)),
    );
  }
}
