import 'package:bold_beauty_lounge/core/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../services/domain/entities/service.dart';

class BookingConfirmationModal extends StatelessWidget {
  final ServiceEntity service;
  final DateTime? selectedDate;
  final String? selectedSlot;
  final VoidCallback onDismiss;

  const BookingConfirmationModal({
    super.key,
    required this.service,
    required this.selectedDate,
    required this.selectedSlot,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: AppColors.popupBackground,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.successBackground, // green-100
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 48,
                  color: AppColors.success,
                ), // green-600
              ),
              const SizedBox(height: 24),
              Text(
                'Réservation confirmée !',
                style: context.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Votre rendez-vous a été enregistré avec succès',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(context, 'Service :', service.name),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      context,
                      'Date :',
                      selectedDate != null
                          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                          : '',
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow(context, 'Heure :', selectedSlot ?? ''),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      context,
                      'Prix :',
                      '${service.price} dh',
                      isPink: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Retour aux services',
                onPressed: () {
                  onDismiss();
                  context.go('/services');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isPink = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.textTheme.bodyMedium),
        Text(
          value,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isPink ? context.colors.primary : context.colors.onSurface,
          ),
        ),
      ],
    );
  }
}
