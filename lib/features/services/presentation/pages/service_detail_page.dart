import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/service.dart';

class ServiceDetailPage extends StatelessWidget {
  final ServiceEntity service;
  const ServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(service.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('${service.durationMinutes} min | ${service.price} dh', style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 20),
            Text(service.description, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.push('/booking', extra: service),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('Réserver', style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
