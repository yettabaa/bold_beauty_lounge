import 'package:flutter/material.dart';
import '../../../../features/services/domain/entities/service.dart';

class BookingPage extends StatefulWidget {
  final ServiceEntity service;
  const BookingPage({super.key, required this.service});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  String? selectedSlot;
  final List<String> slots = ['9h00', '10h00', '11h00', '14h00', '15h00', '16h00'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Réserver : ${widget.service.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choisissez une date :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (date != null) {
                  setState(() => selectedDate = date);
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(selectedDate == null ? 'Sélectionner une date' : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
            ),
            const SizedBox(height: 20),
            if (selectedDate != null) ...[
              const Text('Choisissez un créneau :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: slots.map((slot) {
                  return ChoiceChip(
                    label: Text(slot),
                    selected: selectedSlot == slot,
                    onSelected: (selected) {
                      setState(() => selectedSlot = selected ? slot : null);
                    },
                  );
                }).toList(),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (selectedDate != null && selectedSlot != null)
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Réservation confirmée pour le ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} à $selectedSlot')),
                        );
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    : null,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('Confirmer', style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
