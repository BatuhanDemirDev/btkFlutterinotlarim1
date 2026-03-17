import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geri Dönüş Değeri"),
      ),
      // HATA ÇÖZÜMÜ: Buradaki 'const' kaldırıldı çünkü içindeki işlem dinamik (async).
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // HATA ÇÖZÜMÜ: 'ElevatedonPressed' değil, 'ElevatedButton' olmalı.
            ElevatedButton(
              onPressed: () async {
                final String? secilenRenk = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RenkSec()),
                );
                // Burada istersen secilenRenk'i kullanabilirsin.
                if (secilenRenk != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Seçilen renk: $secilenRenk')),
                  );
                }
              },
              child: const Text('Renk Sec'),
            ), // Parantez buradaki ElevatedButton'ı kapatmalı.
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class RenkSec extends StatelessWidget {
  const RenkSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Renk Seç"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildColorButton(context, "Kırmızı"),
            _buildColorButton(context, "Mavi"),
            _buildColorButton(context, "Yeşil"),
            _buildColorButton(context, 'Sarı')
          ],
        ),
      ),
    );
  }
}

Widget _buildColorButton(BuildContext context, String color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: ElevatedButton(
      // HATA ÇÖZÜMÜ: onPressed isimlendirilmiş parametre olarak belirtilmeli.
      onPressed: () {
        Navigator.pop(context, color);
      },
      // HATA ÇÖZÜMÜ: Text butona ait bir child olmalı, Container'a değil.
      child: Text(color),
    ),
  );
}