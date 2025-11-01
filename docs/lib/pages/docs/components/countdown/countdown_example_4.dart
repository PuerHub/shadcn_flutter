import 'package:shadcn_flutter/shadcn_flutter.dart';

class CountdownExample4 extends StatelessWidget {
  const CountdownExample4({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final targetTime = DateTime.now().add(const Duration(
      days: 3,
      hours: 5,
      minutes: 30,
      seconds: 45,
    ));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Inline format with default abbreviations
        Countdown(
          targetTime: targetTime,
          inline: true,
        ),
        const Gap(16),
        // Inline format with custom labels
        Countdown(
          targetTime: targetTime,
          inline: true,
          dayLabel: 'd',
          hourLabel: 'h',
          minuteLabel: 'm',
          secondLabel: 's',
          numberStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const Gap(16),
        // Inline format without days
        Countdown(
          targetTime: targetTime,
          inline: true,
          showDays: false,
          hourLabel: 'h',
          minuteLabel: 'm',
          secondLabel: 's',
          numberStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
