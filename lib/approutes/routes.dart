import 'package:btkakademi/pageswithroute/navigator_resultw.dart';
import 'package:btkakademi/pageswithroute/veri_aktarimiw.dart';
import 'package:flutter/material.dart';
import 'package:btkakademi/pageswithroute/basic_navw.dart';
import 'package:btkakademi/pageswithroute/navigatorw.dart';

class AppRoutes {
  static const String home = '/';
  static const String basicNavigation = '/basicNavigation';
  static const String returnWithPop = '/returnWithPop';
  static const String dataTransfer = '/dataTransfer';
  
  static Map<String, Widget Function(BuildContext)> get routes => {
    home: (context) => const HomePagew(),
    basicNavigation: (context) => const BasicNavigation(),
    returnWithPop: (context) => const NavigationResultDemo(),
    dataTransfer: (context) => VeriAktarimi(),
  };
}
