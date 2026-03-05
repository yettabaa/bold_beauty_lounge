import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/widgets/information_box.dart';
import '../../../../core/presentation/widgets/app_button.dart';
import '../../../../core/presentation/widgets/app_card.dart';
import '../../../../core/presentation/widgets/shared_app_bar.dart';
import '../../../../config/theme/app_colors.dart';
import '../../domain/entities/service.dart';

class ServiceDetailPage extends StatelessWidget {
  final ServiceEntity service;
  const ServiceDetailPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: SharedAppBar(onBack: () => context.pop()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          children: [
            // Service Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.name, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 16),

                  // Highlighted Badges
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.outline),
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              '${service.durationMinutes} minutes',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.local_offer,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${service.price} dh',
                              style: theme.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Divider(color: AppColors.border, height: 1),
                  ),

                  Text('Description', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Text(service.description),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // CTA Button
            AppButton(
              label: 'Réserver ce service',
              icon: Icons.calendar_today,
              onPressed: () => context.push('/booking', extra: service),
            ),
            const SizedBox(height: 16),

            // Info Box
            const InformationBox(
              message: 'Nos horaires : Du lundi au samedi, de 9h à 19h',
            ),
          ],
        ),
      ),
    );
  }
}
