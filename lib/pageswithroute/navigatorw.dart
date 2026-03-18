import 'package:flutter/material.dart';
import 'package:btkakademi/pageswithroute/basic_navw.dart';
import 'package:btkakademi/pageswithroute/veri_aktarimiw.dart';
import 'package:flutter/services.dart';
import 'navigator_resultw.dart';

class HomePagew extends StatelessWidget {
  const HomePagew({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
  canPop: false, // Sistemin sayfayı otomatik kapatmasını engelliyoruz
  onPopInvokedWithResult: (didPop, result) async {
    // Eğer sayfa zaten kapatıldıysa (başka bir yerden pop edildiyse) bir şey yapma
    if (didPop) {
      return;
    }

    final bool cikilsinmi = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Çıkış"),
            content: const Text("Çıkmak istediğinize emin misiniz?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), 
                child: const Text("Hayır"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), 
                child: const Text("Evet"),
              ),
            ],
          ),
        ) ?? false; // Eğer boşluğa tıklayıp kapatırsa 'false' kabul et

    // Eğer kullanıcı 'Evet' dediyse, sayfayı manuel olarak kapatıyoruz
    if (cikilsinmi && context.mounted) {
       // canPop: false olduğu için sistemi kandırıp manuel pop yapmalıyız
       // Ancak HomePage genelde ana sayfa olduğu için 'pop' yapmak uygulamayı 
       // arka plana atar veya kapatır.
        await SystemNavigator.pop(); 
    }
  },
      child: Scaffold(
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavigationResultDemo()));
                debugPrint("Geri Dönüş Değeri Butonuna Tıklandı");
              }),
            ],
          ),
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