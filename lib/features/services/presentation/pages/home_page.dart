import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bold Beauty Lounge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.spa, size: 100, color: Colors.pinkAccent),
            const SizedBox(height: 20),
            const Text(
              'Bienvenue au Bold Beauty Lounge',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => context.push('/services'),
              child: const Text('Voir les services'),
            ),
          ],
        ),
      ),
    );
  }
}
