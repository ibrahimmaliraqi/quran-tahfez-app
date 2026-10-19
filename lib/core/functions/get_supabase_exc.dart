import 'package:supabase_flutter/supabase_flutter.dart';

String getExceptionMessage({required PostgrestException data}) {
  switch (data.code) {
    case "PGRST204":
      return 'تعذر إضافة المعلم.';
    default:
      print(data.code);
      print(data.message);
      return " ${data.message}حدث خطاااا";
  }
}
