import 'package:flutter/material.dart';

class TopbarStyle {
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const TopbarStyle({
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
  });

  TopbarStyle merge(TopbarStyle? other) {
    if (other == null) return this;
    return TopbarStyle(
      backgroundColor: other.backgroundColor,
      iconColor: other.iconColor,
      textColor: other.textColor,
    );
  }
}
