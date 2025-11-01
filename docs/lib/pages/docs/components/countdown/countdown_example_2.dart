import 'package:shadcn_flutter/shadcn_flutter.dart';

class CountdownExample2 extends StatelessWidget {
  const CountdownExample2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final targetTime = DateTime.now().add(const Duration(
      days: 2,
      hours: 12,
      minutes: 30,
    ));

    return Countdown(
      targetTime: targetTime,
      dayLabel: 'Days',
      hourLabel: 'Hours',
      minuteLabel: 'Mins',
      secondLabel: 'Secs',
      numberStyle: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        color: theme.colorScheme.mutedForeground,
      ),
      spacing: 20.0,
      labelSpacing: 6.0,
      onComplete: () {
        // Countdown complete callback
      },
    );
  }
}
