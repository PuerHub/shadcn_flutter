import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import 'countdown_example_1.dart';

class CountdownTile extends StatelessWidget implements IComponentPage {
  const CountdownTile({super.key});

  @override
  String get title => 'Countdown';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'countdown',
      title: 'Countdown',
      scale: 1.2,
      example: CountdownExample1(),
    );
  }
}
