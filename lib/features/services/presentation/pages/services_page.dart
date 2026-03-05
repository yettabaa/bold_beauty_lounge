import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/presentation/widgets/app_card.dart';
import '../../../../core/presentation/widgets/shared_app_bar.dart';
import '../bloc/services_bloc.dart';
import '../bloc/services_state.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(onBack: () => context.go('/')),
      body: BlocBuilder<ServicesBloc, ServicesState>(
        builder: (context, state) {
          final textTheme = context.textTheme;

          if (state is ServicesLoading || state is ServicesInitial) {
            return const Center(child: CircularProvider());
          } else if (state is ServicesLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              itemCount: state.services.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final service = state.services[index];
                return InkWell(
                  onTap: () => context.push('/services/detail', extra: service),
                  borderRadius: BorderRadius.circular(12),

                  // Service Card
                  child: AppCard(
                    borderRadius: 12,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(service.name, style: textTheme.titleSmall),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${service.durationMinutes} min',
                                    style: textTheme.bodySmall,
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(
                                    Icons.local_offer,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${service.price} dh',
                                    style: textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ServicesError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CircularProvider extends StatelessWidget {
  const CircularProvider({super.key});
  @override
  Widget build(BuildContext context) => const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
  );
}
