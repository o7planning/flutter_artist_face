import 'package:flutter/material.dart';

/// An enterprise-grade, immutable token class containing structural painting metrics
/// and appearance design rules for the top navigation bar layout.
///
/// Integrated into the `FlutterArtist` design ecosystem, [TopbarStyle] aggregates background
/// canvas fills, typography paints, and utility vector symbol icon colors into a single type-safe model.
/// It guarantees child navigation headers preserve clean contrast boundaries across application panels.
class TopbarStyle {
  /// The concrete background canvas paint token coloring applied over the horizontal top bar frame container.
  final Color backgroundColor;

  /// The primary thematic color profile applied to format plaintext runs and status labels inside the bar lane.
  final Color textColor;

  /// The primary thematic color profile applied onto functional vector icon action buttons inside the header track.
  final Color iconColor;

  /// Initializes a production-grade, immutable declarative instance of [TopbarStyle] with explicit style metrics.
  const TopbarStyle({
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
  });

  /// Combines this topbar style template configuration seamlessly with a secondary external style modifier token loop.
  ///
  /// Attributes defined within the [other] argument override this instance's baseline settings completely.
  ///
  /// * [other]: The secondary configuration instance injected to overwrite layout properties.
  TopbarStyle merge(TopbarStyle? other) {
    if (other == null) return this;
    return TopbarStyle(
      backgroundColor: other.backgroundColor,
      iconColor: other.iconColor,
      textColor: other.textColor,
    );
  }
}
