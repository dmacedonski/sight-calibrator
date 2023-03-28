import 'package:flutter/material.dart';
import 'package:sight_calibrator/data/scope.dart';
import 'package:sight_calibrator/scope_fragment.dart';

class ScopesFragment extends StatefulWidget {
  final ScopeDao scopeDao;

  const ScopesFragment({super.key, required this.scopeDao});

  @override
  State<ScopesFragment> createState() => _ScopesFragmentState();
}

class _ScopesFragmentState extends State<ScopesFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Scope>>(
        stream: widget.scopeDao.findAll(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              alignment: Alignment.topCenter,
              child: const Text("Nothing to display, add scope first."),
            );
          }
          final scopes = snapshot.requireData;
          if (scopes.isEmpty) {
            return Container(
              alignment: Alignment.topCenter,
              child: const Text("Nothing to display, add scope first."),
            );
          }
          return ListView.builder(
              itemCount: scopes.length,
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
                      await widget.scopeDao.deleteOne(scopes[index]);
                    },
                    child: ListTile(
                        title: Text(scopes[index].name),
                        subtitle: Text(
                            "One click: ${scopes[index].inchesPerClick} inches at ${scopes[index].forDistance} yards.")));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ScopeFragment(scopeDao: widget.scopeDao)));
          },
          child: const Icon(Icons.add_rounded)),
    );
  }
}
