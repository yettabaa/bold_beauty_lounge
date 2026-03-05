import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../features/services/domain/entities/service.dart';
import '../../../../core/presentation/widgets/app_button.dart';
import '../widgets/booking_confirmation_modal.dart';
import '../widgets/booking_section_card.dart';

class BookingPage extends StatefulWidget {
  final ServiceEntity service;
  const BookingPage({super.key, required this.service});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  String? selectedSlot;
  bool showConfirmation = false;

  final List<String> slots = [
    '09:00',
    '10:00',
    '11:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
  ];

  late List<DateTime> availableDates;

  @override
  void initState() {
    super.initState();
    availableDates = List.generate(14, (index) {
      return DateTime.now().add(Duration(days: index));
    });
  }

  String _formatDisplayDate(DateTime date) {
    final weekdays = ['lun.', 'mar.', 'mer.', 'jeu.', 'ven.', 'sam.', 'dim.'];
    final months = [
      'janv.',
      'févr.',
      'mars',
      'avr.',
      'mai',
      'juin',
      'juil.',
      'août',
      'sept.',
      'oct.',
      'nov.',
      'déc.',
    ];
    return '${weekdays[date.weekday - 1]} ${date.day} ${months[date.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : AppColors.textSecondary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: const Border(
                      left: BorderSide(color: AppColors.primary, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.service.name,
                        style: context.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.service.durationMinutes} min • ${widget.service.price} dh',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Date Selection
                BookingSectionCard(
                  title: 'Choisissez une date',
                  icon: Icons.calendar_today,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365 * 100),
                            ),
                            locale: const Locale('fr', 'FR'),
                          );
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate == null
                                    ? 'Sélectionner une date'
                                    : _formatDisplayDate(selectedDate!),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  color: selectedDate == null
                                      ? null
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              Icon(
                                Icons.calendar_month,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Time Selection
                BookingSectionCard(
                  title: 'Choisissez un horaire',
                  icon: Icons.access_time,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2.2,
                        ),
                    itemCount: slots.length,
                    itemBuilder: (context, index) {
                      final time = slots[index];
                      final isSelected = selectedSlot == time;

                      return InkWell(
                        onTap: () => setState(() => selectedSlot = time),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryLight
                                : Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : Theme.of(context).colorScheme.outline,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            time,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? AppColors.primary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // Confirm Button
                AppButton(
                  label: 'Confirmer la réservation',
                  icon: Icons.check,
                  onPressed: (selectedDate != null && selectedSlot != null)
                      ? () => setState(() => showConfirmation = true)
                      : null,
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),

        // Confirmation Modal Overlay
        if (showConfirmation)
          BookingConfirmationModal(
            service: widget.service,
            selectedDate: selectedDate,
            selectedSlot: selectedSlot,
            onDismiss: () => setState(() => showConfirmation = false),
          ),
      ],
    );
  }
}
