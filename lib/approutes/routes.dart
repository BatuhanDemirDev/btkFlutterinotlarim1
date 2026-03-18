import 'package:btkakademi/pageswithroute/navigator_resultw.dart';
import 'package:btkakademi/pageswithroute/veri_aktarimiw.dart';
import 'package:flutter/material.dart';
import 'package:btkakademi/pageswithroute/basic_navw.dart';
import 'package:btkakademi/pageswithroute/navigatorw.dart';

class AppRoutes {
  static const String home = '/';
  static const String temel_navigation = '/basic';
  static const String return_with_pop = '/return';
  static const String veri_aktarimi = '/veri_aktarimi';
  

  static Map<String, Widget Function(BuildContext)> get routes =>{
  home: (context) => const HomePagew(),
  temel_navigation:(context) => const BasicNavigation(),
  return_with_pop:(context) => const  NavigationResultDemo(),
  veri_aktarimi:(context) =>  VeriAktarimi(),


};
}