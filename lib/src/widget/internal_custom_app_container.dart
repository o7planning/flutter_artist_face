import 'package:flutter/material.dart';

class InternalCustomAppContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final int type;
  static const int _typeDefaullt = 0;

  const InternalCustomAppContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
  }) : type = _typeDefaullt;

  Color _color(BuildContext context) {
    switch (type) {
      case _typeDefaullt:
        return Theme.of(context).cardColor;
      default:
        return Colors.transparent;
    }
  }

  Border? _border() {
    switch (type) {
      case _typeDefaullt:
        return Border.all(color: Colors.black12);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: _color(context),
        borderRadius: BorderRadius.circular(2),
        border: _border(),
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
