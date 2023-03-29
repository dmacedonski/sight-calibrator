import 'package:flutter/material.dart';

class SessionSummaryFragment extends StatefulWidget {
  final int verticalClicks;
  final int horizontalClicks;

  const SessionSummaryFragment(
      {super.key,
      required this.verticalClicks,
      required this.horizontalClicks});

  @override
  State<StatefulWidget> createState() => _SessionSummaryFragmentState();
}

class _SessionSummaryFragmentState extends State<SessionSummaryFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Summary")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Vertical", style: TextStyle(fontSize: 24)),
            Text(widget.verticalClicks.abs().toString(),
                style: const TextStyle(fontSize: 48)),
            Text("clicks ${widget.verticalClicks > 0 ? "up" : "down"}",
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 48),
            const Text("Horizontal", style: TextStyle(fontSize: 24)),
            Text(widget.horizontalClicks.abs().toString(),
                style: const TextStyle(fontSize: 48)),
            Text("clicks ${widget.horizontalClicks > 0 ? "left" : "right"}",
                style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
