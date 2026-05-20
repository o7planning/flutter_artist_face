import 'package:flutter/material.dart';
import 'package:flutter_artist_face/src/style/topbar_style.dart';

import 'sidebar_style.dart';

class FaceStyle {
  final Color scaffoldBackground;
  final TopbarStyle topbarStyle;
  final SidebarStyle sidebarStyle;

  /// Pure explicit constructor demanding comprehensive parameters.
  const FaceStyle({
    required this.scaffoldBackground,
    required this.topbarStyle,
    required this.sidebarStyle,
  });

  /// Factory blueprint engine building an entirely unified design setup from a single Flutter [seedColor].
  /// Factory blueprint engine building an entirely unified design setup from a single Flutter [seedColor].
  factory FaceStyle.simple(
    Color seedColor, {
    Brightness brightness = Brightness.light,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
    final isDark = brightness == Brightness.dark;

    // --- High-contrast Topbar Logic ---
    // Ensure the topbar has a distinct container background or uses surface color with safe contrast.
    final Color topbarBg = isDark
        ? colorScheme.surfaceContainer
        : colorScheme.surface;
    final Color topbarContentColor = colorScheme.onSurface;

    // --- Distinct Sidebar Layering Logic ---
    // Sidebar should feel like a solid structural layer, separate from the scaffold body.
    final Color sidebarBg = isDark
        ? colorScheme.surfaceContainerLow
        : colorScheme
              .surfaceContainerLow; // surfaceContainerLow creates a beautiful distinct gray/tint coat

    return FaceStyle(
      // Use surfaceContainerLowest or standard surface to keep content cards popping out nicely
      scaffoldBackground: isDark
          ? colorScheme.surface
          : colorScheme.surfaceContainerLowest,

      topbarStyle: TopbarStyle(
        backgroundColor: topbarBg,
        iconColor: topbarContentColor,
        textColor: topbarContentColor,
      ),

      sidebarStyle: SidebarStyle(
        backgroundColor: sidebarBg,
        expandedWidth: 240,
        collapsedWidth: 60,
        groupPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        groupTitleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: colorScheme.primary,
          letterSpacing: 0.8,
        ),
        groupSubtitleStyle: TextStyle(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
          fontSize: 10,
        ),
        itemPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        itemBorderRadius: 8.0,
        itemIconColor: colorScheme.onSurfaceVariant,
        itemTextColor: colorScheme.onSurface,
        // Make interaction states clearly visible
        itemHoverColor: colorScheme.primary.withValues(alpha: 0.08),
        itemSelectedColor: colorScheme.primaryContainer.withValues(alpha: 0.4),
      ),
    );
  }

  /// Default baseline safety values fallback.
  factory FaceStyle.defaults() => FaceStyle.simple(Colors.blue);

  FaceStyle merge(FaceStyle? other) {
    if (other == null) return this;
    return FaceStyle(
      scaffoldBackground: other.scaffoldBackground,
      topbarStyle: topbarStyle.merge(other.topbarStyle),
      sidebarStyle: sidebarStyle.merge(other.sidebarStyle),
    );
  }
}
