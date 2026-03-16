import 'package:flutter/material.dart';

class BasicNavigation extends StatelessWidget {
  const BasicNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Temel Navigasyon")),
      body: Center(
      child: Column(children: [
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Ayarlar()));
          }, child: Text("Ayarlar Sayfasına Git ")),
          ElevatedButton(onPressed: () {
            debugPrint("Push Kullanıldı");
            Navigator.pop(context, MaterialPageRoute(builder: (context) => BasicNavigation()));
          }, child: Text("Geri Dön ")),
      ],
            ),
      ),
    );
  }
}


class Ayarlar extends StatelessWidget {
  const Ayarlar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ayarlar Sayfası "), 
      automaticallyImplyActions: false,
      ),
      body: Center(
      child: Column(children: [
          ElevatedButton(onPressed: () {
            debugPrint("Push Kullanıldı");
            Navigator.pop(context, MaterialPageRoute(builder: (context) => BasicNavigation()));
          }, child: Text("Geri Dön ")),
      ],
            ),
      ),
    );
  }
}