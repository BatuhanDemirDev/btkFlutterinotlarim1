import 'package:flutter/material.dart';

class BasicNavigation extends StatelessWidget {
  const BasicNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {'id': 'N/A', 'isim': 'N/A'};
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temel Navigasyon"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID: ${args['id'].toString()}'),
            Text('İsim: ${args['isim'].toString()}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const Ayarlar())
                );
              }, 
              child: const Text("Ayarlar Sayfasına Git")
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                debugPrint("Geri dönülüyor");
                Navigator.pop(context);
              }, 
              child: const Text("Geri Dön")
            ),
          ],
        ),
      ),
    );
  }
}

class Ayarlar extends StatelessWidget {
  const Ayarlar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar Sayfası"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint("Ayarlardan geri dönülüyor");
                Navigator.pop(context);
              }, 
              child: const Text("Geri Dön")
            ),
          ],
        ),
      ),
    );
  }
}
