import 'package:intl/intl.dart';

class AppString {
  static final String currentTime = DateFormat(
    'yyyy-MM-dd HH:mm:ss',
  ).format(DateTime.now());
}
