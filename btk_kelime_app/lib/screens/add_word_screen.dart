import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddWordScreen extends StatefulWidget {
  const AddWordScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _englishController,
              decoration: const InputDecoration(
                labelText: 'İngilizce Kelime',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
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
            ElevatedButton(
              onPressed: () {
                // Kaydetme işlemi burada yapılacak
              },
              child: const Text('Kelimeyi Kaydet'),
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
              onPressed: () {
                // Resim ekleme işlemi burada yapılacak
              },
              icon: const Icon(Icons.image),
              label: const Text('Resim Ekle'),
            ),
            SizedBox(height: 8),
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
              ),
          ],
        ),
      ),
    );
  }
}
