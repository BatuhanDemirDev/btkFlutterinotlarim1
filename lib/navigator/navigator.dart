import 'package:flutter/material.dart';
import 'package:btkakademi/navigator/Pages/basic_nav.dart';
import 'package:btkakademi/navigator/Pages/veri_aktarimi.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Navigator Kullanımı")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildNavigationButton("Temel Navigasyon", "Push ve Pop Kullanımı",onPressed: () {
              debugPrint("Temel Navigasyon Butonuna Tıklandı");
              Navigator.push(context, MaterialPageRoute(builder: (context) => BasicNavigation()));
            }),
            _buildNavigationButton("Isimlendirilmiş Rotalar", "Named Routes Kullanımı",onPressed: () {
              debugPrint("Isimlendirilmiş Rotalar Butonuna Tıklandı");
            }),
            _buildNavigationButton("Veri Aktarımı", "Sayfalar Arası Veri Gönderme",onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => VeriAktarimi()));
              debugPrint("Veri Aktarımı Butonuna Tıklandı");
            }),
            _buildNavigationButton("Geri Dönüş Değeri", "Sayfadan Veri Alma",onPressed: () {
              debugPrint("Geri Dönüş Değeri Butonuna Tıklandı");
            }),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavigationButton(String myTitle, String mySubtitle ,{required VoidCallback onPressed}) {
    return Card(
      child: ListTile(
        title: Text(myTitle),
        subtitle: Text(mySubtitle),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onPressed,
      ),
    );
  }
}