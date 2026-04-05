import 'package:flutter/material.dart';
import 'package:flutter_artist_face/src/style/topbar_style.dart';

import 'sidebar_style.dart';

class FaceStyle {
  final Color? scaffoldBackground;
  final TopbarStyle? topbarStyle;
  final SidebarStyle? sidebarStyle;

  const FaceStyle({
    this.scaffoldBackground,
    this.topbarStyle,
    this.sidebarStyle,
  });

  factory FaceStyle.defaults() => FaceStyle(
    scaffoldBackground: Colors.white,
    topbarStyle: TopbarStyle.defaults(),
    sidebarStyle: SidebarStyle.defaults(),
  );

  FaceStyle merge(FaceStyle? other) {
    if (other == null) return this;
    return FaceStyle(
      scaffoldBackground: scaffoldBackground ?? other.scaffoldBackground,
      topbarStyle: (topbarStyle ?? const TopbarStyle()).merge(
        other.topbarStyle,
      ),
      sidebarStyle: (sidebarStyle ?? const SidebarStyle()).merge(
        other.sidebarStyle,
      ),
    );
  }
}
