// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:btk_kelime_app/screens/add_word_screen.dart';
import 'package:btk_kelime_app/screens/word_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:btk_kelime_app/sevices/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isarService = IsarService();
  
  try {
    await isarService.init(); 
    final words = await isarService.getAllWords();
    debugPrint(words.toString());
  } catch (e) {
    debugPrint('Main Dartta isarServis Çalıştırılamadı $e');
  }
  
  runApp(KelimeApp(isarService: isarService));
}

class KelimeApp extends StatelessWidget {
  final IsarService isarService;

  const KelimeApp({
    super.key, // super.key kullanımı daha moderndir
    required this.isarService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KelimeApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // ÖNEMLİ: Yukarıdan gelen isarService'i buraya paslıyoruz
      home: MainPage(isarService: isarService), 
    );
  }
}

class MainPage extends StatefulWidget { 
  final IsarService isarService;
  const MainPage({super.key, required this.isarService});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Ekran listesi
  //final List<Widget> _screens = [];
  List<Widget> getScreens() {
    return [
      WordList(isarService: widget.isarService),
      Center(
        child: AddWordScreen(isarService: widget.isarService), // Burada IsarService'i geçiyoruz
      ),
    ];
  }


  int _selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(title: const Text('Kelimelerim')),
      
      body: getScreens() [_selectedScreen], 
      bottomNavigationBar: NavigationBar(selectedIndex:_selectedScreen , destinations:[
      NavigationDestination(icon: Icon(Icons.list_alt ) , label: "Kelimeler"),
      NavigationDestination(icon: Icon(Icons.add_circle_outline) , label: "Ekle"),
      ],
      onDestinationSelected:(value) {
          setState(() {
            _selectedScreen = value;
              });
      },
      ),
    );
  }
}