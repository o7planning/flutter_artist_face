import 'package:flutter/material.dart';
import 'package:flutter_artist_face/src/style/topbar_style.dart';

import 'sidebar_style.dart';

// Assuming TopbarStyle and SidebarStyle pathing setups exist safely inside your local workspace matrix
// import 'package:flutter_artist_face/src/styles/topbar_style.dart';
// import 'package:flutter_artist_face/src/styles/sidebar_style.dart';

/// An enterprise-grade design configuration orchestrator that aggregates complete visual
/// theme tokens and styling configurations for structural administration dashboards.
///
/// Tailored for the `FlutterArtist` framework, [FaceStyle] binds layout canvas boundaries,
/// global topbar content alignments, and multi-tier side menu rendering rules seamlessly.
class FaceStyle {
  /// The foundational color profile applied to paint the master [Scaffold] background.
  final Color scaffoldBackground;

  /// The decorative styling tokens and background properties governing the top navigation bar.
  final TopbarStyle topbarStyle;

  /// The structural layout configuration and interaction metrics governing the side navigation drawer.
  final SidebarStyle sidebarStyle;

  /// Pure explicit constructor demanding comprehensive parameters.
  const FaceStyle({
    required this.scaffoldBackground,
    required this.topbarStyle,
    required this.sidebarStyle,
  });

  /// Factory blueprint engine building an entirely unified design setup from a single Flutter [seedColor].
  ///
  /// Dynamically generates harmonious [ColorScheme] palettes to adapt gracefully across light and dark
  /// system environments. It enforces explicit layer contrasts, transforming surface containers
  /// to separate structural navigation boundaries cleanly from the core main canvas workspace.
  ///
  /// * [seedColor]: The core baseline source color vector utilized to derive the global application palette.
  /// * [brightness]: Resolves whether the styling structures apply dark-mode or light-mode visual design standards.
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
  ///
  /// Automatically seeds the simple theme pipeline using the standard framework [Colors.blue] token.
  factory FaceStyle.defaults() => FaceStyle.simple(Colors.blue);

  /// Cascades and overlays a secondary input theme configuration over current baseline style states safely.
  ///
  /// * [other]: The external input theme specifications injected to overwrite primary layout properties.
  FaceStyle merge(FaceStyle? other) {
    if (other == null) return this;
    return FaceStyle(
      scaffoldBackground: other.scaffoldBackground,
      topbarStyle: topbarStyle.merge(other.topbarStyle),
      sidebarStyle: sidebarStyle.merge(other.sidebarStyle),
    );
  }
}
