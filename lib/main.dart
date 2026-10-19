import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quran_tahfez/core/router/app_router.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/core/service/server_locator.dart';
import 'package:quran_tahfez/core/utils/app_bloc_observer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://lfinjlfkdoatydqqsocp.supabase.co',
    publishableKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxmaW5qbGZrZG9hdHlkcXFzb2NwIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc5MjM4Nzc0NSwiZXhwIjoyMTA3OTYzNzQ1fQ.ktsfthhRufT9DogpFJBdP5pT_VQD-IB-_ONanQqcaZk',
  );
  setupLocator();
  await PrefsHelper.init();
  Bloc.observer = AppBlocObserver();
  timeago.setLocaleMessages('ar', timeago.ArMessages());

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: Locale("ar"),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      debugShowCheckedModeBanner: false,
      title: 'تحفيظ',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'cairo',
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
