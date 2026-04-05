import 'package:flutter/material.dart';

class TopbarStyle {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  const TopbarStyle({this.backgroundColor, this.iconColor, this.textColor});

  factory TopbarStyle.defaults() =>
      const TopbarStyle(backgroundColor: Colors.blue);

  TopbarStyle merge(TopbarStyle? other) {
    if (other == null) return this;
    return TopbarStyle(
      backgroundColor: backgroundColor ?? other.backgroundColor,
      iconColor: iconColor ?? other.iconColor,
      textColor: textColor ?? other.textColor,
    );
  }
}
