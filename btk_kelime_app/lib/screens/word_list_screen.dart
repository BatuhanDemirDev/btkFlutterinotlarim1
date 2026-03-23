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

  @override
  void initState() {
    super.initState();
    // Sayfa açıldığında verileri çekme işlemini bir kez başlatıyoruz
    _getAllWords = _getWordsfromDB();
  }
  void _refreshWord(){
    setState(() {
      _getAllWords = _getWordsfromDB();
    });
  }
  Future<List<Word>> _getWordsfromDB() async {
    return await widget.isarService.getAllWords();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // İleride buraya arama veya filtreleme kartı koyabilirsin
        const Card(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Kelimelerim"),
        )),
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
                // Veri var ama liste boş mu? (Bölüm 5.3)
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text("Henüz kelime eklenmemiş."));
                }
                return _buildListView(snapshot.data!);
              } 
              // Her durumda bir widget dönmek zorundayız
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  // Widget dönüş tipini belirttik (Bölüm 4.10: Refactoring)
Widget _buildListView(List<Word> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        var oankiKelime = data[index];
        return ListTile(
          title: Text(oankiKelime.englishWord),
          subtitle: Text(oankiKelime.turkishWord),
          // Switch kullanımını buradaki gibi düzeltiyoruz:
          trailing: Switch(
            value: oankiKelime.isLearned,
            onChanged: (value) async {
              // Veritabanını güncelle
              await widget.isarService.toogleWordLearn(oankiKelime.id);
              _refreshWord();
            },
          ),
        );
      },
    );
}
}