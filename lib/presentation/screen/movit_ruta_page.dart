
import 'package:clean_arch_get/domain/models/movit/movit.dart';
import 'package:design_system_weincode/atoms/weincode_separeted.dart';
import 'package:flutter/material.dart';

class Movitgape extends StatelessWidget {
 final  Future<Movit> movit;
  const Movitgape({super.key, required this.movit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: const Text('Movitgape 🐬')),
      body: FutureBuilder<Movit>(
        future: movit,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Movit movit = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(movit.content.plan.toString())
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.hasError}');
          }
          return const Center(
              child: SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator()));
        },
      )
    );
  }
}