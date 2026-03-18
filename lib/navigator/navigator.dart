import 'package:btkakademi/approutes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final bool? cikilsinmi = await showDialog<bool>(
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
        );
        if (cikilsinmi == true && context.mounted) {
          await SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Navigator Kullanımı")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildNavigationButton("Temel Navigasyon", "Push ve Pop Kullanımı", onPressed: () {
                debugPrint("Temel Navigasyon Butonuna Tıklandı");
                Navigator.pushNamed(context, AppRoutes.basicNavigation, arguments: {'id': 1, 'isim': 'Batuhan'});
              }),
              _buildNavigationButton("Isimlendirilmiş Rotalar", "Named Routes Kullanımı", onPressed: () {
                debugPrint("Isimlendirilmiş Rotalar Butonuna Tıklandı");
              }),
              _buildNavigationButton("Veri Aktarımı", "Sayfalar Arası Veri Gönderme", onPressed: () {
                Navigator.pushNamed(context, AppRoutes.dataTransfer);
                debugPrint("Veri Aktarımı Butonuna Tıklandı");
              }),
              _buildNavigationButton("Geri Dönüş Değeri", "Sayfadan Veri Alma", onPressed: () {
                Navigator.pushNamed(context, AppRoutes.returnWithPop);
                debugPrint("Geri Dönüş Değeri Butonuna Tıklandı");
              }),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildNavigationButton(String myTitle, String mySubtitle, {required VoidCallback onPressed}) {
    return Card(
      child: ListTile(
        title: Text(myTitle),
        subtitle: Text(mySubtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onPressed,
      ),
    );
  }
}
