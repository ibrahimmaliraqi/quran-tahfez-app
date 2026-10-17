import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/enums/popup_menu_action_enum.dart';
import 'package:quran_tahfez/core/widgets/custom_pop_menu.dart';

class AppPopupMenus {
  AppPopupMenus._();

  static const List<PopupMenuItemModel<PopupMenuActionEnums>> common = [
    PopupMenuItemModel(
      value: PopupMenuActionEnums.edit,
      title: 'تعديل',
      icon: Icons.edit_rounded,
    ),
    PopupMenuItemModel(
      value: PopupMenuActionEnums.delete,
      title: 'حذف',
      icon: Icons.delete_outline_rounded,
      color: Colors.red,
    ),
    PopupMenuItemModel(
      value: PopupMenuActionEnums.details,
      title: 'التفاصيل',
      icon: Icons.info_outline_rounded,
    ),
  ];
}
