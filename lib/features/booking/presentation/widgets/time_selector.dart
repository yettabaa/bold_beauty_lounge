import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../config/theme/app_colors.dart';

class TimeSelector extends StatelessWidget {
  final List<String> slots;
  final String? selectedSlot;
  final Function(String) onSlotSelected;

  const TimeSelector({
    super.key,
    required this.slots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          onTap: () => onSlotSelected(time),
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
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? AppColors.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        );
      },
    );
  }
}
