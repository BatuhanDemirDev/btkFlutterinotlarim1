import 'package:flutter/material.dart';

class Sayacwidget extends StatefulWidget {
  const Sayacwidget({super.key});

  @override
  State<Sayacwidget> createState() => SayacwidgetState();
}

class SayacwidgetState extends State<Sayacwidget> {
  int _sayac = 0; // Değişken artık burada

  // Dışarıdan erişilecek fonksiyonlar
  void sayacArttir() {
    setState(() {
      _sayac++;
    });
  }

  void sayacAzalt() {
    setState(() {
      _sayac--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _sayac.toString(),
      style: const TextStyle(fontSize: 48),
    );
  }
}