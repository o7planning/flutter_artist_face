part of '../menu_model.dart';

/// An enterprise-grade configuration token mapping layout actions and graphic assets
/// onto utility menu nodes inside the top bar header strip.
class TopMenuItemModel {
  /// An optional image asset provider referencing administrative avatars, branding graphics, or profile tokens.
  final ImageProvider? imageProvider;

  /// Fires a custom programmatic execution handler closure immediately upon intercepting interactive click events.
  final void Function() onPressed;

  /// Constructs a standard immutable instance of [TopMenuItemModel] with explicit tap parameters.
  const TopMenuItemModel({this.imageProvider, required this.onPressed});
}
