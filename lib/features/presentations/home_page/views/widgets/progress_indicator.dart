import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MyProgressIndicator extends StatefulWidget {
  const MyProgressIndicator({Key? key, required this.steps}) : super(key: key);
  final int steps;

  @override
  State<MyProgressIndicator> createState() => _MyProgressIndicatorState();
}

@override
class _MyProgressIndicatorState extends State<MyProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return StepProgressIndicator(
      totalSteps: 30,
      currentStep: widget.steps,
      size: 8,
      padding: 0,
      selectedColor: Colors.yellow,
      unselectedColor: Colors.cyan,
      roundedEdges: Radius.circular(10),
      selectedGradientColor: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.red, Colors.orange],
      ),
      unselectedGradientColor: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.teal, Colors.green],
      ),
    );
  }
}
