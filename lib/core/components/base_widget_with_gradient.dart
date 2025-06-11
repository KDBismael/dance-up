import 'package:flutter/material.dart';

class BaseWidgetWithGradient extends StatelessWidget {
  const BaseWidgetWithGradient({
    super.key,
    required this.children,
    this.gradientStopEnd = 0.2,
    this.gradientColor = const Color(0xFF673AB7),
  });

  final List<Widget> children;
  final double gradientStopEnd;
  final Color gradientColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, gradientStopEnd],
              colors: [gradientColor, Colors.white]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.viewPaddingOf(context).top,
            ),
            Expanded(child: Column(children: children)),
            // ...children,
            SizedBox(
              height: MediaQuery.viewPaddingOf(context).bottom,
            ),
          ],
        ),
      ),
    );
  }
}
