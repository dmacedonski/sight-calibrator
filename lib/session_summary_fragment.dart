import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.summary)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.vertical,
                style: const TextStyle(fontSize: 24)),
            Text(widget.verticalClicks.abs().toString(),
                style: const TextStyle(fontSize: 48)),
            Text(
                widget.verticalClicks > 0
                    ? AppLocalizations.of(context)!.clicksUp
                    : AppLocalizations.of(context)!.clicksDown,
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 48),
            Text(AppLocalizations.of(context)!.horizontal,
                style: const TextStyle(fontSize: 24)),
            Text(widget.horizontalClicks.abs().toString(),
                style: const TextStyle(fontSize: 48)),
            Text(
                widget.horizontalClicks > 0
                    ? AppLocalizations.of(context)!.clicksLeft
                    : AppLocalizations.of(context)!.clicksRight,
                style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
