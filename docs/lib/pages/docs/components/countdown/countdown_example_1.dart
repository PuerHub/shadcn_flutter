import 'package:shadcn_flutter/shadcn_flutter.dart';

class CountdownExample1 extends StatelessWidget {
  const CountdownExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // Set target time to 3 days, 5 hours, 30 minutes, and 45 seconds from now
    final targetTime = DateTime.now().add(const Duration(
      days: 3,
      hours: 5,
      minutes: 30,
      seconds: 45,
    ));

    return Countdown(
      targetTime: targetTime,
      onComplete: () {
        // Called when countdown reaches zero
      },
    );
  }
}
