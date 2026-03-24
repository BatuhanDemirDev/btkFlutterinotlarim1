import 'package:btk_kelime_app/models/word.dart';
import 'package:btk_kelime_app/sevices/isar_service.dart';
import 'package:flutter/material.dart';

class WordList extends StatefulWidget {
  final IsarService isarService;
  const WordList({super.key, required this.isarService});

  @override
  State<WordList> createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  late Future<List<Word>> _getAllWords;
  List<Word> _kelimeler = [];

  @override
  void initState() {
    super.initState();
    _getAllWords = _getWordsfromDB();
  }

  // Veritabanından verileri tekrar çeken yardımcı fonksiyon
  Future<List<Word>> _getWordsfromDB() async {
    return await widget.isarService.getAllWords();
  }

  // Kelimeyi güncelleme mantığı
  Future<void> _toggleUpdateWord(Word oankiKelime) async {
    // 1. Veritabanında güncelle (Bölüm 8.5)
    await widget.isarService.toogleWordLearn(oankiKelime.id);

    // 2. Ekrandaki listeyi güncelle (Bölüm 4.3)
    setState(() {
      final index = _kelimeler.indexWhere((element) => element.id == oankiKelime.id);
      if (index != -1) {
        _kelimeler[index].isLearned = !_kelimeler[index].isLearned;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Kelimelerim"),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Word>>(
            future: _getAllWords,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Hata: ${snapshot.error}"));
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text("Henüz kelime eklenmemiş."));
                }
                // Veriyi listeye eşitleyip widget'ı döndür (Bölüm 5.3)
                _kelimeler = snapshot.data!;
                return _buildListView(_kelimeler);
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListView(List<Word> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        var oankiKelime = data[index];
        return ListTile(
          title: Text(oankiKelime.englishWord),
          subtitle: Text(oankiKelime.turkishWord),
          leading: Chip(label: Text(oankiKelime.wordType)),
          trailing: Switch(
            value: oankiKelime.isLearned,
            // Burada fonksiyonu düzgünce çağırdık (Bölüm 6.6)
            onChanged: (value) => _toggleUpdateWord(oankiKelime),
          ),
        );
      },
    );
  }
}