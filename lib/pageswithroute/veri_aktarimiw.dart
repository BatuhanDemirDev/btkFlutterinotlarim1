import 'package:flutter/material.dart';

class VeriAktarimi extends StatelessWidget {
final List<Ogrenciler> tumOgrenciler =List.generate(50, (index) => Ogrenciler(isim: "Öğrenci $index", yas: 20 + index, sehir: "Şehir $index"));
VeriAktarimi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Veri Aktarımı")),
      body: ListView.builder(
        itemCount: tumOgrenciler.length,
        itemBuilder: (context, index) {
          final secilenKisi = tumOgrenciler[index];
          return Card(
            child: ListTile(
              title: Text(secilenKisi.isim),
              subtitle: Text("Şehir: ${secilenKisi.sehir}"),
              trailing: Icon(Icons. arrow_right), leading: CircleAvatar(
              child: Text(secilenKisi.yas.toString()),
            ), 
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OgrenciDetay(ogrenci: secilenKisi)));
              },
            ),
          );
        },
      ),
    );
  }
}

class _tekOgrenciDetay extends StatelessWidget {
  const _tekOgrenciDetay();

  @override
  Widget build(BuildContext context) {
    return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {
          final ogrBatuhan = Ogrenciler(isim: "Batuhan", yas: 25, sehir: "Ankara");
          Navigator.push(context, MaterialPageRoute(builder: (context) => OgrenciDetay(ogrenci: ogrBatuhan)));
        }, child: Text("Detaylar Sayfasına git ")),
    ],
          ),
    );
  }
}

class Ogrenciler {
  String isim;
  int yas;
  String sehir;

  Ogrenciler
  ({required this.isim,
    required this.yas,
    required this.sehir});
}

class OgrenciDetay extends StatelessWidget {
  final Ogrenciler ogrenci;
  const OgrenciDetay({super.key, required this.ogrenci});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Öğrenci Detayları"),
        
      ),
      // Tüm Text'leri bir Column içine alıyoruz
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Öğrenci Detayları Gösterilecek", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20), // Aralarda boşluk bırakmak iyidir
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