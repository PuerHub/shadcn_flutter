---
title: "Example: components/refresh_trigger/refresh_trigger_tile.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RefreshTriggerTile extends StatelessWidget implements IComponentPage {
  const RefreshTriggerTile({super.key});

  @override
  String get title => 'Refresh Trigger';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'refresh_trigger',
      title: 'Refresh Trigger',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 250,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Refresh indicator area
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        angle: 0.5,
                        child: Icon(
                          Icons.refresh,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'Pull to refresh',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content area
```
