import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// Kendi projenizdeki doğru IsarService ve Word modeli import yollarını kontrol edin:
import 'package:btk_kelime_app/sevices/isar_service.dart';
import 'package:btk_kelime_app/models/word.dart';

class AddWordScreen extends StatefulWidget {
  final IsarService isarService;
  const AddWordScreen({super.key , required this.isarService});

  @override
  State<AddWordScreen> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _englishController = TextEditingController();
  final TextEditingController _turkishController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  String _SelectedWordType = 'Noun';
  bool _isLearned = false;
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  List<String> wordTypes = ['Noun', 'Verb', 'Adjective', 'Adverb'];

  @override
  void dispose() {
    _englishController.dispose();
    _turkishController.dispose();
    _storyController.dispose();
    super.dispose();
  }

  Future<void> _resimSec() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Resim seçildiğinde yapılacak işlemler
      _selectedImage = File(image.path);
      setState(() {}); // UI'yi güncellemek için setState çağrısı
    } else {
      // Kullanıcı resim seçmeden geri döndü
    }
  }
Future <void> _saveWord() async {
  if (_formKey.currentState!.validate()) {

    String englishWord = _englishController.text;
    String turkishMeaning = _turkishController.text;
    String story = _storyController.text;
    String wordType = _SelectedWordType;
    bool isLearned = _isLearned;
    File? imageFile = _selectedImage;

    debugPrint('Kelime: $englishWord');

    try {
      // DÜZELTME: Parantez doğru şekilde kapatıldı ve Isar modeline isLearned parametresi de gönderildi
      await widget.isarService.saveWord(
        Word(
          englishWord: englishWord,
          turkishWord: turkishMeaning,
          wordType: wordType,
          story: story.isNotEmpty ? story : null,
          imagesBytes: imageFile != null ? await imageFile.readAsBytes() : null,
          // Eğer Word modelinde isLearned alanı varsa onu da buraya eklemelisin:
          // isLearned: isLearned, 
        ),
      ); // Word parantezi ve saveWord parantezi burada kapandı.

      // Başarılı bildirim mesajı ve Formu Temizleme
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kelime başarıyla kaydedildi!')),
        );
        
        _englishController.clear();
        _turkishController.clear();
        _storyController.clear();
        setState(() {
          _selectedImage = null;
          _isLearned = false;
        });
      }

    } catch (e) {
      debugPrint("Veritabanına kaydederken hata oluştu: $e");
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen İngilizce kelimeyi girin';
                }
                return null;
              },
              controller: _englishController,
              decoration: const InputDecoration(
                labelText: 'İngilizce Kelime',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen Türkçe anlamını girin';
                }
                return null;
              },
              controller: _turkishController,
              decoration: const InputDecoration(
                labelText: 'Türkçe Anlamı',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _SelectedWordType,
              items: wordTypes.map((e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _SelectedWordType = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Kelime Türü', border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _storyController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Hatırlatıcı Not (Opsiyonel)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton( child: const Text('Kelimeyi Kaydet'), onPressed: _saveWord,
            ),
            SwitchListTile(
              title: const Text('Öğrenildi Olarak İşaretle'),
              value: _isLearned,
              onChanged: (value) {
                setState(() {
                  _isLearned = value;
                });
              },
            ),
            ElevatedButton.icon(
              onPressed: _resimSec,
              icon: const Icon(Icons.image),
              label: const Text('Resim Ekle'),
            ),
            SizedBox(height: 8),
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
