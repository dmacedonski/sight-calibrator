import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sight_calibrator/data/scope.dart';
import 'package:sight_calibrator/data/target.dart';
import 'package:sight_calibrator/session_summary_fragment.dart';

class MarkHitsFragment extends StatefulWidget {
  final CameraDescription camera;
  final Scope scope;
  final Target target;

  const MarkHitsFragment(
      {super.key,
      required this.camera,
      required this.scope,
      required this.target});

  @override
  State<StatefulWidget> createState() => _MarkHitsFragmentState();
}

class _MarkHitsFragmentState extends State<MarkHitsFragment> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  final _points = <Point<double>>[];

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final children = <Widget>[
                CameraPreview(_cameraController),
                CustomPaint(
                    painter:
                        _CirclePaint(MediaQuery.of(context).size.width / 2))
              ];
              for (var point in _points) {
                children.add(Positioned(
                    top: point.y - 3,
                    left: point.x - 3,
                    child: CustomPaint(painter: _DotPaint())));
              }
              children.add(GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) {
                  setState(() {
                    _points.add(Point(
                        details.localPosition.dx, details.localPosition.dy));
                  });
                },
              ));
              children.add(Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: Text(AppLocalizations.of(context)!.clear),
                          onPressed: () {
                            setState(() {
                              _points.clear();
                            });
                          },
                        ),
                        ElevatedButton(
                          child: Text(AppLocalizations.of(context)!.showResult),
                          onPressed: () {
                            if (_points.length < 3) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .markAtLeastThreePoints)));
                            } else {
                              final screenSize =
                                  MediaQuery.of(context).size.width;
                              final avgX = _points.map((e) => e.x).reduce(
                                      (value, element) => value + element) /
                                  _points.length;
                              final avgY = _points.map((e) => e.y).reduce(
                                      (value, element) => value + element) /
                                  _points.length;
                              final horizontalClicks = _calculateClicks(
                                  _calculateImpactLocationMovement(
                                      widget.target, screenSize, avgX),
                                  widget.target,
                                  widget.scope);
                              final verticalClick = _calculateClicks(
                                  _calculateImpactLocationMovement(
                                      widget.target, screenSize, avgY),
                                  widget.target,
                                  widget.scope);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => SessionSummaryFragment(
                                      verticalClicks: verticalClick,
                                      horizontalClicks: horizontalClicks)));
                            }
                          },
                        ),
                      ],
                    ),
                  )));
              return Stack(
                alignment: AlignmentDirectional.topStart,
                children: children,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  double _calculateImpactLocationMovement(
      Target target, double screenSize, double positionOnScreen) {
    return (target.size * positionOnScreen / screenSize) - (target.size / 2);
  }

  int _calculateClicks(
      double impactLocationMovement, Target target, Scope scope) {
    return ((impactLocationMovement / scope.inchesPerClick) *
            (scope.forDistance / target.distance))
        .round();
  }
}

class _CirclePaint extends CustomPainter {
  final double _radius;

  const _CirclePaint(this._radius);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.indigo
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(_radius, _radius), _radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _DotPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(6, 6), 6, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
