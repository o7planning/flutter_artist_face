import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobilePhone() {
    if (!kIsWeb) {
      return true;
    } else {
      return false;
    }
  }

  static bool isWeb() {
    return kIsWeb;
  }

  static bool isMobileWidth(double width) {
    return width < 850;
  }

  static bool isTabletWidth(double width) {
    return width < 1100 && width >= 850;
  }

  static bool isDesktopWidth(double width) {
    return width >= 1100;
  }

  static bool isDesktopPlatform() {
    if (kIsWeb) return false;
    return Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  }

  static bool isMobile(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    if (size < 850) return true;

    if (kIsWeb) return false;

    if (isDesktopPlatform()) return false;

    return true;
  }

  static bool isTab(context) {
    final size = MediaQuery.of(context).size.width;
    if (size < 1100 && size >= 850) {
      return true;
    } else {
      return false;
    }
  }

  static bool isDesktop(context) {
    final size = MediaQuery.of(context).size.width;
    if (size >= 1100) {
      return true;
    } else {
      return false;
    }
  }
}
