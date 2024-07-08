import 'package:flutter/material.dart';

class ProgressLine extends StatelessWidget {
  final double progress;
  final Color innerColor;
  final Color outerColor;
  final double width;

  const ProgressLine({
    Key? key,
    required this.progress,
    required this.innerColor,
    required this.outerColor,
    required this.width,
  })  : assert(progress >= 0.0 && progress <= 1.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: width,
      decoration: BoxDecoration(
        color: innerColor,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: progress,
          child: Container(
            color: outerColor,
          ),
        ),
      ),
    );
  }
}
