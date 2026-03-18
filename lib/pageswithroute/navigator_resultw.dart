import 'package:flutter/material.dart';

class NavigationResultDemo extends StatefulWidget {
const NavigationResultDemo({super.key});

  @override
  State<NavigationResultDemo> createState() => _NavigationResultDemoState();
}

class _NavigationResultDemoState extends State<NavigationResultDemo> {
  String? secilenRenk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geri Dönüş Değeri"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final String? secilenRenk = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RenkSec()),
                );                
                if (secilenRenk != null) {
                  setState(() {
                    this.secilenRenk = secilenRenk;
                  });
                }
              },
              child: const Text('Renk Sec'),
            ), 
            const SizedBox(height: 20),
            Text(
              secilenRenk != null
                  ? "Seçilen Renk: $secilenRenk"
                  : "Henüz bir renk seçilmedi.",
              style: const TextStyle(fontSize: 18),
            ),
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