import 'package:flutter/material.dart';

/// A unified container used across the FlutterArtist Face framework
/// to maintain consistent styling for cards, sidebars, and bars.
class InternalCustomAppContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  /// Custom border decoration. If provided, it overrides the default border.
  final BoxBorder? border;

  /// Custom border radius. Defaults to 2.0 as per LeanTek legacy style.
  final double borderRadius;

  /// The background color of the container.
  /// If null, it defaults to the Theme's cardColor.
  final Color? color;

  const InternalCustomAppContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.border,
    this.borderRadius = 2.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        /// Use provided color or fallback to Theme's cardColor for consistency
        color: color ?? Theme.of(context).cardColor,

        /// Flexible radius for different UI components (TopBar vs Cards)
        borderRadius: BorderRadius.circular(borderRadius),

        /// Apply the custom border (like the bottom-only border in TopMenuBar)
        /// or a default light border if none is specified.
        border: border ?? Border.all(color: Colors.black12, width: 0.5),
      ),
      child: child,
    );
  }
}
