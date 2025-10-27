---
title: "Example: components/toggle/toggle_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a basic boolean Toggle that flips its value when pressed.

class ToggleExample1 extends StatefulWidget {
  const ToggleExample1({super.key});

  @override
  _ToggleExample1State createState() => _ToggleExample1State();
}

class _ToggleExample1State extends State<ToggleExample1> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Toggle(
      // Simple boolean toggle; style/semantics similar to a ToggleButton.
      value: value,
      onChanged: (v) {
        setState(() {
          value = v;
        });
      },
      child: const Text('Toggle'),
    );
  }
}

```
