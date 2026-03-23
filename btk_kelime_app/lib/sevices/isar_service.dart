import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:btk_kelime_app/models/word.dart'; // Kendi proje adınla uyumlu olduğundan emin ol

class IsarService {
  late Isar isar;

  Future<void> init() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      // WordSchema'nın tanınması için 'word.g.dart' dosyasının oluşmuş olması gerekir
      isar = await Isar.open([WordSchema], directory: directory.path);
    } catch (e) {
      debugPrint('Isar init olurken hata $e');
    }
  }
  Future<void> saveWord(Word word) async {
    try {
      await isar.writeTxn(() async {
        final id = await isar.words.put(word);
        debugPrint('Yeni Kelime olan ${word.englishWord} $id idsi ile eklenmiştir');
      });
    } catch (e) {
      debugPrint('Kelime eklenirken hata çıktı $e');
    }
  }
  Future<List<Word>> getAllWords() async {
    try {
      final words = await isar.words.where().findAll();
      return words;
    } catch (e) {
      debugPrint('Tüm Kelimeler Getirilirken hata $e');
      return [];
    }
  }
  Future<void> deleteWord(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.words.delete(id);
        debugPrint('Id değeri $id olan nesne silinmiştir');
      });
    } catch (e) {
      debugPrint('Kelime silinirken hata $e');
    }
  }
  Future<void> updateWord(Word word) async {
    try {
      await isar.writeTxn(() async {
        final id = await isar.words.put(word);
        debugPrint('Kelime olan ${word.englishWord} $id idsi ile güncellendi');
      });
    } catch (e) {
      debugPrint('Kelime Güncellenirken hata $e');
    }
  }
  Future<void> toogleWordLearn(int id )async{
try {
      await isar.writeTxn(() async {
        final word = await isar.words.get(id);
        if (word != null){
          word.isLearned = !word.isLearned;
          await isar.words.put(word);
          debugPrint('Kelime güncellendi'); 
        }else{
          debugPrint('Kelime Bulunamadı'); 
        }
        
      });
    } catch (e) {
      debugPrint('Kelime Güncellenirken hata $e');
    } 
  }
}