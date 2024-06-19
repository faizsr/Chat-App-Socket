import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget smallScreen;
  final Widget largeScreen;

  const ResponsiveWidget(
      {super.key, required this.smallScreen, required this.largeScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 700) {
        return largeScreen;
      } else {
        return smallScreen;
      }
    });
  }
}
