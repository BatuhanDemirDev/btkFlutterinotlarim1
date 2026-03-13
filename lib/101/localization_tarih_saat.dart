import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeKullanimi extends StatefulWidget {
  const DateTimeKullanimi({super.key});

  @override
  State<DateTimeKullanimi> createState() => _DateTimeKullanimiState();
}

class _DateTimeKullanimiState extends State<DateTimeKullanimi> {
  DateTime _secilenTarih = DateTime.now();
  TimeOfDay _secilenSaat = TimeOfDay.now();

  Future<void> _tarihSec() async {
    final DateTime? yeniTarih = await showDatePicker(
      context: context,
      initialDate: _secilenTarih,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      selectableDayPredicate: (date) {
        return date.weekday != DateTime.saturday && date.weekday != DateTime.sunday;
      },
      locale: const Locale('tr', 'TR'),
    );

    if (yeniTarih != null && yeniTarih != _secilenTarih) {
      setState(() {
        _secilenTarih = yeniTarih;
      });
    }
  }

  Future<void> _saatSec() async {
    final TimeOfDay? yeniSaat = await showTimePicker(
      context: context,
      initialTime: _secilenSaat,
    );

    if (yeniSaat != null && yeniSaat != _secilenSaat) {
      setState(() {
        _secilenSaat = yeniSaat;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tarih ve Saati formatlıyoruz
    final String formatlanmisTarih = DateFormat('dd-MM-yyyy').format(_secilenTarih);
    final String formatlanmisSaat = _secilenSaat.format(context); // Saat formatı için context yeterli

    return Scaffold(
      appBar: AppBar(title: const Text("Tarih ve Saat Seçimi")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _BaslikWidget(),
            const SizedBox(height: 20),
            
            // Tarih Bölümü
            ElevatedButton(
              onPressed: _tarihSec,
              child: const Text("Tarih Seç"),
            ),
            Text(formatlanmisTarih, style: Theme.of(context).textTheme.displayMedium),
            
            const SizedBox(height: 30),
            
            // Saat Bölümü
            ElevatedButton(
              onPressed: _saatSec,
              child: const Text("Saat Seç"),
            ),
            Text(formatlanmisSaat, style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}

// Kodu daha temiz tutmak için küçük parçalara (Widget) bölebiliriz
class _BaslikWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "Randevu Detayları",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}