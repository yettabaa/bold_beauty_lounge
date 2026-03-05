import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../features/services/domain/entities/service.dart';
import '../../../../core/presentation/widgets/app_button.dart';
import '../widgets/booking_confirmation_modal.dart';
import '../widgets/booking_section_card.dart';
import '../widgets/date_selector.dart';
import '../widgets/time_selector.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: theme.scaffoldBackgroundColor,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.close,
                    color: theme.brightness == Brightness.dark
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
                    color: theme.colorScheme.surface,
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
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.service.durationMinutes} min • ${widget.service.price} dh',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Date Selection
                BookingSectionCard(
                  title: 'Choisissez une date',
                  icon: Icons.calendar_today,
                  child: DateSelector(
                    selectedDate: selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Time Selection
                BookingSectionCard(
                  title: 'Choisissez un horaire',
                  icon: Icons.access_time,
                  child: TimeSelector(
                    slots: slots,
                    selectedSlot: selectedSlot,
                    onSlotSelected: (slot) {
                      setState(() {
                        selectedSlot = slot;
                      });
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
