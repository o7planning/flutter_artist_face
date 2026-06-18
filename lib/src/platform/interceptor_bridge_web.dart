import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

Widget buildInterceptorShield({
  required Widget child,
  bool intercepting = true,
}) {
  return PointerInterceptor(intercepting: intercepting, child: child);
}
