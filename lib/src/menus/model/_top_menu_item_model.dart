part of '../menu_model.dart';

class TopMenuItemModel {
  final ImageProvider? imageProvider;
  final void Function() onPressed;

  const TopMenuItemModel({this.imageProvider, required this.onPressed});
}
