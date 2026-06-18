import 'package:flutter/material.dart';

/// Fallback widget that does nothing on non-supported platforms
Widget buildInterceptorShield({
  required Widget child,
  bool intercepting = true,
}) {
  return child;
}
