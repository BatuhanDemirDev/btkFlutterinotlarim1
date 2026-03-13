import 'package:btkakademi/101/localization_tarih_saat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('tr', 'TR'),
    Locale('en', 'US'),
  ],
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home:  (DateTimeKullanimi()),
    );
  }
}