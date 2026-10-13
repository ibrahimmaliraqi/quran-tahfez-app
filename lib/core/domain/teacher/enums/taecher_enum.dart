import 'package:flutter/material.dart';

enum TeacherEnumAction {
  edit,
  delete,
}

extension TeacherEnumActionExtension on TeacherEnumAction {
  String get title {
    switch (this) {
      case TeacherEnumAction.edit:
        return 'تعديل';

      case TeacherEnumAction.delete:
        return 'حذف';
    }
  }

  IconData get icon {
    switch (this) {
      case TeacherEnumAction.edit:
        return Icons.edit_outlined;

      case TeacherEnumAction.delete:
        return Icons.delete_outline;
    }
  }

  Color get color {
    switch (this) {
      case TeacherEnumAction.edit:
        return const Color(0xFF1E6553);

      case TeacherEnumAction.delete:
        return Colors.red;
    }
  }
}
