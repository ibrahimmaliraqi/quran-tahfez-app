import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/widgets/custom_pop_menu.dart';

class AppPopupMenus {
  AppPopupMenus._();

  static const List<PopupMenuItemModel<String>> common = [
    PopupMenuItemModel(
      value: 'edit',
      title: 'تعديل',
      icon: Icons.edit_rounded,
    ),
    PopupMenuItemModel(
      value: 'delete',
      title: 'حذف',
      icon: Icons.delete_outline_rounded,
      color: Colors.red,
    ),
    PopupMenuItemModel(
      value: 'details',
      title: 'التفاصيل',
      icon: Icons.info_outline_rounded,
    ),
  ];
}
