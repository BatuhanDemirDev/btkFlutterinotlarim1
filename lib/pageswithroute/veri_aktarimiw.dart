import 'package:flutter/material.dart';

class VeriAktarimi extends StatelessWidget {
  static final List<Ogrenciler> _tumOgrenciler = List.generate(50, (index) => Ogrenciler(
    isim: "Öğrenci $index", 
    yas: 20 + index, 
    sehir: "Şehir $index"
  ));

  const VeriAktarimi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Veri Aktarımı")),
      body: ListView.builder(
        itemCount: _tumOgrenciler.length,
        itemBuilder: (context, index) {
          final secilenKisi = _tumOgrenciler[index];
          return Card(
            child: ListTile(
              title: Text(secilenKisi.isim),
              subtitle: Text("Şehir: ${secilenKisi.sehir}"),
              leading: CircleAvatar(
                child: Text(secilenKisi.yas.toString()),
              ),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => OgrenciDetay(ogrenci: secilenKisi))
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Ogrenciler {
  final String isim;
  final int yas;
  final String sehir;

  const Ogrenciler({
    required this.isim,
    required this.yas,
    required this.sehir,
  });
}

class OgrenciDetay extends StatelessWidget {
  final Ogrenciler ogrenci;
  const OgrenciDetay({super.key, required this.ogrenci});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Öğrenci Detayları")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Öğrenci Detayları", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("Öğrenci Adı: ${ogrenci.isim}"),
            Text("Öğrenci Yaşı: ${ogrenci.yas}"),
            Text("Öğrenci Şehri: ${ogrenci.sehir}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Geri Dön"),
            ),
          ],
        ),
      ),
    );
  }
}
