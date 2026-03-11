import 'package:flutter/material.dart';

class TextFormFieldKullanimi extends StatefulWidget {
  const TextFormFieldKullanimi({super.key});

  @override
  State<TextFormFieldKullanimi> createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  String deger = '';
  String username = '', email = '', password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Klavyenin ekranı kaydırması ve taşma hatası olmaması için SingleChildScrollView ekledik
      body: SingleChildScrollView(
        child: Padding(
          padding: MyPadding.allPadding,
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: MyPadding.customPaddingPNG,
                  child: Image.asset(
                    'assets/yayinci.jpg',
                    height: 200,
                    // Eğer resim yoksa hata vermemesi için errorBuilder eklenebilir
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 100),
                  ),
                ),

                /// USERNAME
                Padding(
                  padding: MyPadding.customPaddingPNG,
                  child: TextFormField(
                    onSaved: (newValue) => username = newValue ?? '',
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'En az 6 karakter giriniz';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() => deger = value),
                    maxLength: 10,
                    decoration: _buildInputDecoration('Username', 'Lütfen Username giriniz'),
                  ),
                ),

                /// EMAIL
                TextFormField(
                  onSaved: (newValue) => email = newValue ?? '',
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Geçerli bir email giriniz';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: _buildInputDecoration('Email', 'Lütfen Email giriniz'),
                ),

                const SizedBox(height: 16),

                /// ŞİFRE
                TextFormField(
                  onSaved: (newValue) => password = newValue ?? '' ,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Şifre en az 6 karakter olmalı';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: _buildInputDecoration('Şifre', 'Lütfen Şifre giriniz'),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Temizle'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // DOĞRU PARANTEZ YAPISI BURADA
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form doğrulandı'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          _formKey.currentState!.save();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Form doğrulanmadı',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text('Kaydet'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Kod tekrarını önlemek için küçük bir yardımcı fonksiyon
  InputDecoration _buildInputDecoration(String label, String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade300,
      hintText: hint,
      labelText: label,
      prefixIcon: const Icon(Icons.account_circle),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    );
  }
}

class MyPadding {
  static const EdgeInsets allPadding = EdgeInsets.all(16.0);
  static const EdgeInsets customPaddingPNG = EdgeInsets.only(top: 48, bottom: 16);
}