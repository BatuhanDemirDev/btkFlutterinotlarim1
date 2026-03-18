import 'package:btkakademi/101/sayacwidget.dart';
import 'package:flutter/material.dart';

class Sayacuygulamasi extends StatelessWidget {
Sayacuygulamasi({super.key});
final _sayacKey = GlobalKey<SayacwidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sayaç Uygulaması'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sayaç Değeri:', style: TextStyle(fontSize: 24),),
            Sayacwidget(key: _sayacKey,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _sayacKey.currentState?.sayacArttir();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Sayaç Arttır'),
              ),
              SizedBox(width: 20),
              ElevatedButton(onPressed: (){
              _sayacKey.currentState?.sayacAzalt();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ), 
              child: const Text('Sayaç Azalt')
            ),
          ],
        ), ]
      ),
    ),
    );
}
}