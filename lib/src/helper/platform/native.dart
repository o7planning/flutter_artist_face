import 'dart:io';

bool get isDesktopPlatformId =>
    Platform.isMacOS || Platform.isWindows || Platform.isLinux;
