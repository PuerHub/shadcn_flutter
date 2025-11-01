import 'package:shadcn_flutter/shadcn_flutter.dart';

class CountdownExample3 extends StatelessWidget {
  const CountdownExample3({super.key});

  @override
  Widget build(BuildContext context) {
    final targetTime = DateTime.now().add(const Duration(
      days: 5,
      hours: 8,
      minutes: 15,
      seconds: 30,
    ));

    return Countdown(
      targetTime: targetTime,
      showDays: false,
      hourLabel: 'H',
      minuteLabel: 'M',
      secondLabel: 'S',
      numberStyle: const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
      ),
      spacing: 16.0,
    );
  }
}
