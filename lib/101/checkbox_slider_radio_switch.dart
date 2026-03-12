import 'package:flutter/material.dart';

class FormElemanlariSayfasi extends StatefulWidget {
  const FormElemanlariSayfasi({super.key});

  @override
  State<FormElemanlariSayfasi> createState() => _FormElemanlariSayfasiState();
}

class _FormElemanlariSayfasiState extends State<FormElemanlariSayfasi> {
  // Durum değişkenleri (State)
  bool _switchValue = false;
  bool _checkboxValue = false;
  int? _radioValue = 1; // Hangi radyo butonun seçili olduğunu tutar
  double _sliderValue = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seçim Bileşenleri Sözlüğü')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- SWITCH LIST TILE ---
          const _Baslik(metin: "1. SwitchListTile (Aç/Kapat)"),
          SwitchListTile(
            title: const Text("Bildirimleri Aç"),
            subtitle: Text(_switchValue ? "Bildirimler aktif" : "Bildirimler kapalı"),
            secondary: const Icon(Icons.notifications_active),
            value: _switchValue,
            onChanged: (bool value) {
              setState(() => _switchValue = value);
            },
          ),
          const Divider(),

          // --- CHECKBOX LIST TILE ---
          const _Baslik(metin: "2. CheckboxListTile (Çoklu Seçim)"),
          CheckboxListTile(
            title: const Text("Kullanım Koşullarını Okudum"),
            subtitle: const Text("Devam etmek için onaylamanız gerekir"),
            controlAffinity: ListTileControlAffinity.leading, // Kutucuğu sola alır
            value: _checkboxValue,
            onChanged: (bool? value) {
              setState(() => _checkboxValue = value ?? false);
            },
          ),
          const Divider(),

          // --- RADIO LIST TILE ---
          const _Baslik(metin: "3. RadioListTile (Tekli Seçim)"),
          RadioListTile<int>(
            title: const Text("Seçenek A"),
            value: 1,
            groupValue: _radioValue,
            onChanged: (int? value) {
              setState(() => _radioValue = value);
            },
          ),
          RadioListTile<int>(
            title: const Text("Seçenek B"),
            value: 2,
            groupValue: _radioValue,
            onChanged: (int? value) {
              setState(() => _radioValue = value);
            },
          ),
          const Divider(),

          // --- SLIDER ---
          const _Baslik(metin: "4. Slider (Değer Aralığı)"),
          Text("Seçilen Değer: ${_sliderValue.toInt()}", 
               textAlign: TextAlign.center, 
               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 10, // Çizgili bölmeler ekler
            label: _sliderValue.round().toString(), // Sürüklerken üzerinde değer yazar
            onChanged: (double value) {
              setState(() => _sliderValue = value);
            },
          ),
        ],
      ),
    );
  }
}

// Yardımcı başlık widget'ı (Kod tekrarını önlemek için)
class _Baslik extends StatelessWidget {
  final String metin;
  const _Baslik({required this.metin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(metin, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
    );
  }
}