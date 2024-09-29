import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget addPadding({required EdgeInsets edgeInsets}) {
    return Padding(
      padding: edgeInsets,
      child: this,
    );
  }

  Widget alignCenter() {
    return Center(
      child: this,
    );
  }

  Widget widgetWithSpace(
      {double? top, double? bottom, double? left, double? right}) {
    return Padding(
      padding: EdgeInsets.only(
          top: top ?? 0,
          bottom: bottom ?? 0,
          right: right ?? 0,
          left: left ?? 0),
      child: this,
    );
  }
}
