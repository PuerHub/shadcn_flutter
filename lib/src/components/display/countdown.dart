import 'dart:async';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for [Countdown] widget.
///
/// Provides default styling values that can be overridden on individual
/// [Countdown] instances. This allows for consistent styling across
/// multiple countdown timers in an application while still permitting
/// per-instance customization when needed.
///
/// Used with [ComponentTheme] to provide theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<CountdownTheme>(
///   data: CountdownTheme(
///     numberStyle: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
///     labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
///     spacing: 16.0,
///   ),
///   child: MyApp(),
/// );
/// ```
class CountdownTheme {
  /// The default text style for countdown numbers.
  ///
  /// If null, individual [Countdown] widgets will use their own style
  /// or fall back to the default theme style.
  final TextStyle? numberStyle;

  /// The default text style for time unit labels (days, hours, etc.).
  ///
  /// If null, individual [Countdown] widgets will use their own style
  /// or fall back to the default theme style.
  final TextStyle? labelStyle;

  /// The default spacing between countdown units.
  ///
  /// If null, individual [Countdown] widgets will use their own spacing
  /// or fall back to 12.0.
  final double? spacing;

  /// The default spacing between the label and number within each unit.
  ///
  /// If null, individual [Countdown] widgets will use their own spacing
  /// or fall back to 4.0.
  final double? labelSpacing;

  /// Creates a [CountdownTheme] with the specified styling options.
  ///
  /// Parameters:
  /// - [numberStyle] (TextStyle?, optional): Default text style for numbers.
  /// - [labelStyle] (TextStyle?, optional): Default text style for labels.
  /// - [spacing] (double?, optional): Default spacing between units.
  /// - [labelSpacing] (double?, optional): Default spacing between label and number.
  ///
  /// All parameters are optional and will fall back to widget-level defaults
  /// or system defaults when not specified.
  const CountdownTheme({
    this.numberStyle,
    this.labelStyle,
    this.spacing,
    this.labelSpacing,
  });

  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional updates where
  /// null getters preserve the original value.
  ///
  /// Parameters:
  /// - [numberStyle] (ValueGetter<TextStyle?>?, optional): New number style.
  /// - [labelStyle] (ValueGetter<TextStyle?>?, optional): New label style.
  /// - [spacing] (ValueGetter<double?>?, optional): New spacing value.
  /// - [labelSpacing] (ValueGetter<double?>?, optional): New label spacing value.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   numberStyle: () => TextStyle(fontSize: 36),
  ///   spacing: () => 20.0,
  /// );
  /// ```
  CountdownTheme copyWith({
    ValueGetter<TextStyle?>? numberStyle,
    ValueGetter<TextStyle?>? labelStyle,
    ValueGetter<double?>? spacing,
    ValueGetter<double?>? labelSpacing,
  }) {
    return CountdownTheme(
      numberStyle: numberStyle == null ? this.numberStyle : numberStyle(),
      labelStyle: labelStyle == null ? this.labelStyle : labelStyle(),
      spacing: spacing == null ? this.spacing : spacing(),
      labelSpacing: labelSpacing == null ? this.labelSpacing : labelSpacing(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountdownTheme &&
        other.numberStyle == numberStyle &&
        other.labelStyle == labelStyle &&
        other.spacing == spacing &&
        other.labelSpacing == labelSpacing;
  }

  @override
  int get hashCode =>
      Object.hash(numberStyle, labelStyle, spacing, labelSpacing);
}

/// A widget that displays a countdown timer to a target timestamp.
///
/// [Countdown] provides a real-time countdown display showing the remaining time
/// until a specified target date/time. It supports displaying days (optional),
/// hours, minutes, and seconds with customizable labels and styling.
///
/// The countdown automatically updates every second until it reaches zero.
/// Time unit labels are displayed above the numbers for clear readability.
///
/// Key features:
/// - Real-time countdown to a target timestamp
/// - Optional days display (controlled by [showDays])
/// - Customizable i18n labels for time units
/// - Flexible styling through theme integration
/// - Automatic cleanup of timers on dispose
/// - Callback when countdown completes ([onComplete])
///
/// The widget uses a timer that updates every second, calculating the
/// remaining time from the current moment to the target timestamp.
///
/// Common use cases:
/// - Event countdowns
/// - Sale/offer expiration timers
/// - Session timeout displays
/// - Deadline reminders
/// - Time-limited challenges
///
/// Example:
/// ```dart
/// Countdown(
///   targetTime: DateTime.now().add(Duration(days: 2, hours: 5, minutes: 30)),
///   showDays: true,
///   dayLabel: 'Days',
///   hourLabel: 'Hours',
///   minuteLabel: 'Minutes',
///   secondLabel: 'Seconds',
///   onComplete: () => print('Countdown finished!'),
/// );
/// ```
class Countdown extends StatefulWidget {
  /// The target timestamp to count down to.
  ///
  /// The countdown will display the remaining time from now until this timestamp.
  /// When the current time reaches or exceeds this timestamp, the countdown
  /// stops and [onComplete] is called if provided.
  final DateTime targetTime;

  /// Whether to display the days component.
  ///
  /// If true, shows days as part of the countdown (e.g., "2d 5h 30m 15s").
  /// If false, hours may exceed 24 to include the days component
  /// (e.g., "53h 30m 15s" for 2 days and 5 hours).
  ///
  /// Defaults to true.
  final bool showDays;

  /// Label text for the days unit.
  ///
  /// Displayed above the days number when [showDays] is true.
  /// Use this for internationalization of the days label.
  ///
  /// If null, uses the value from [ShadcnLocalizations.timeDaysAbbreviation].
  final String? dayLabel;

  /// Label text for the hours unit.
  ///
  /// Displayed above the hours number.
  /// Use this for internationalization of the hours label.
  ///
  /// If null, uses the value from [ShadcnLocalizations.timeHoursAbbreviation].
  final String? hourLabel;

  /// Label text for the minutes unit.
  ///
  /// Displayed above the minutes number.
  /// Use this for internationalization of the minutes label.
  ///
  /// If null, uses the value from [ShadcnLocalizations.timeMinutesAbbreviation].
  final String? minuteLabel;

  /// Label text for the seconds unit.
  ///
  /// Displayed above the seconds number.
  /// Use this for internationalization of the seconds label.
  ///
  /// If null, uses the value from [ShadcnLocalizations.timeSecondsAbbreviation].
  final String? secondLabel;

  /// Override text style for the countdown numbers.
  ///
  /// If null, uses the style from [CountdownTheme] or defaults to
  /// a large bold font from the theme.
  final TextStyle? numberStyle;

  /// Override text style for the time unit labels.
  ///
  /// If null, uses the style from [CountdownTheme] or defaults to
  /// a smaller font with muted color from the theme.
  final TextStyle? labelStyle;

  /// Override spacing between countdown units (days, hours, etc.).
  ///
  /// If null, uses the spacing from [CountdownTheme] or defaults to 12.0.
  final double? spacing;

  /// Override spacing between the label and number within each unit.
  ///
  /// If null, uses the spacing from [CountdownTheme] or defaults to 4.0.
  final double? labelSpacing;

  /// Callback invoked when the countdown reaches zero.
  ///
  /// Called once when the current time reaches or exceeds [targetTime].
  /// The timer stops after this callback is invoked.
  final VoidCallback? onComplete;

  /// Whether to display the countdown in inline text format.
  ///
  /// If true, displays as inline text like "3d 5h 30m 45s".
  /// If false, displays in a column layout with labels above numbers.
  ///
  /// Defaults to false.
  final bool inline;

  /// Creates a [Countdown] widget.
  ///
  /// Parameters:
  /// - [targetTime] (DateTime, required): The timestamp to count down to.
  /// - [showDays] (bool, optional): Whether to show days component. Defaults to true.
  /// - [dayLabel] (String?, optional): Label for days. If null, uses localized abbreviation.
  /// - [hourLabel] (String?, optional): Label for hours. If null, uses localized abbreviation.
  /// - [minuteLabel] (String?, optional): Label for minutes. If null, uses localized abbreviation.
  /// - [secondLabel] (String?, optional): Label for seconds. If null, uses localized abbreviation.
  /// - [numberStyle] (TextStyle?, optional): Override style for numbers.
  /// - [labelStyle] (TextStyle?, optional): Override style for labels.
  /// - [spacing] (double?, optional): Override spacing between units.
  /// - [labelSpacing] (double?, optional): Override spacing between label and number.
  /// - [onComplete] (VoidCallback?, optional): Callback when countdown finishes.
  /// - [inline] (bool, optional): Whether to display in inline text format. Defaults to false.
  ///
  /// Example:
  /// ```dart
  /// Countdown(
  ///   targetTime: DateTime(2025, 12, 31, 23, 59, 59),
  ///   showDays: false,
  ///   hourLabel: '时',
  ///   minuteLabel: '分',
  ///   secondLabel: '秒',
  ///   numberStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
  ///   onComplete: () => showDialog(...),
  /// );
  /// ```
  const Countdown({
    super.key,
    required this.targetTime,
    this.showDays = true,
    this.dayLabel,
    this.hourLabel,
    this.minuteLabel,
    this.secondLabel,
    this.numberStyle,
    this.labelStyle,
    this.spacing,
    this.labelSpacing,
    this.onComplete,
    this.inline = false,
  });

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  Timer? _timer;
  late final ValueNotifier<Duration> _remainingTime;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = ValueNotifier(_calculateRemainingTime());
    _startTimer();
  }

  @override
  void didUpdateWidget(Countdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetTime != widget.targetTime) {
      _isCompleted = false;
      _remainingTime.value = _calculateRemainingTime();
      _timer?.cancel();
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _remainingTime.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      _updateRemainingTime();
    });
  }

  void _updateRemainingTime() {
    final remaining = _calculateRemainingTime();

    if (remaining <= Duration.zero) {
      _remainingTime.value = Duration.zero;
      _timer?.cancel();
      if (!_isCompleted) {
        _isCompleted = true;
        widget.onComplete?.call();
      }
    } else {
      _remainingTime.value = remaining;
    }
  }

  Duration _calculateRemainingTime() {
    final difference = widget.targetTime.difference(DateTime.now());
    return difference.isNegative ? Duration.zero : difference;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<CountdownTheme>(context);
    final localizations = ShadcnLocalizations.of(context);

    final numberStyle = styleValue(
      widgetValue: widget.numberStyle,
      themeValue: compTheme?.numberStyle,
      defaultValue: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.foreground,
      ),
    );

    final labelStyle = styleValue(
      widgetValue: widget.labelStyle,
      themeValue: compTheme?.labelStyle,
      defaultValue: TextStyle(
        fontSize: 12,
        color: theme.colorScheme.mutedForeground,
      ),
    );

    final spacing = styleValue(
      widgetValue: widget.spacing,
      themeValue: compTheme?.spacing,
      defaultValue: 12.0,
    );

    final labelSpacing = styleValue(
      widgetValue: widget.labelSpacing,
      themeValue: compTheme?.labelSpacing,
      defaultValue: 4.0,
    );

    // Get localized labels
    final dayLabel = widget.dayLabel ?? localizations.timeDaysAbbreviation;
    final hourLabel = widget.hourLabel ?? localizations.timeHoursAbbreviation;
    final minuteLabel =
        widget.minuteLabel ?? localizations.timeMinutesAbbreviation;
    final secondLabel =
        widget.secondLabel ?? localizations.timeSecondsAbbreviation;

    return ValueListenableBuilder<Duration>(
      valueListenable: _remainingTime,
      builder: (context, duration, _) {
        final timeComponents = _getTimeComponents(duration);

        if (widget.inline) {
          return _buildInlineCountdown(
            timeComponents,
            dayLabel: dayLabel,
            hourLabel: hourLabel,
            minuteLabel: minuteLabel,
            secondLabel: secondLabel,
            numberStyle: numberStyle,
          );
        }

        return _buildColumnCountdown(
          timeComponents,
          dayLabel: dayLabel,
          hourLabel: hourLabel,
          minuteLabel: minuteLabel,
          secondLabel: secondLabel,
          numberStyle: numberStyle,
          labelStyle: labelStyle,
          spacing: spacing,
          labelSpacing: labelSpacing,
        );
      },
    );
  }

  /// Calculate time components from duration
  ({int days, int hours, int minutes, int seconds}) _getTimeComponents(
      Duration duration) {
    final days = widget.showDays ? duration.inDays : 0;
    final hours = widget.showDays
        ? duration.inHours.remainder(24)
        : duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return (days: days, hours: hours, minutes: minutes, seconds: seconds);
  }

  /// Build inline text format countdown
  Widget _buildInlineCountdown(
    ({int days, int hours, int minutes, int seconds}) components, {
    required String dayLabel,
    required String hourLabel,
    required String minuteLabel,
    required String secondLabel,
    required TextStyle numberStyle,
  }) {
    final parts = <String>[
      if (widget.showDays)
        '${components.days.toString().padLeft(2, '0')}$dayLabel',
      '${components.hours.toString().padLeft(2, '0')}$hourLabel',
      '${components.minutes.toString().padLeft(2, '0')}$minuteLabel',
      '${components.seconds.toString().padLeft(2, '0')}$secondLabel',
    ];

    return Text(parts.join(' '), style: numberStyle);
  }

  /// Build column layout countdown
  Widget _buildColumnCountdown(
    ({int days, int hours, int minutes, int seconds}) components, {
    required String dayLabel,
    required String hourLabel,
    required String minuteLabel,
    required String secondLabel,
    required TextStyle numberStyle,
    required TextStyle labelStyle,
    required double spacing,
    required double labelSpacing,
  }) {
    final timeUnits = [
      if (widget.showDays)
        (label: dayLabel, value: components.days),
      (label: hourLabel, value: components.hours),
      (label: minuteLabel, value: components.minutes),
      (label: secondLabel, value: components.seconds),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < timeUnits.length; i++) ...[
          _buildTimeUnit(
            label: timeUnits[i].label,
            value: timeUnits[i].value.toString().padLeft(2, '0'),
            numberStyle: numberStyle,
            labelStyle: labelStyle,
            labelSpacing: labelSpacing,
          ),
          if (i < timeUnits.length - 1) SizedBox(width: spacing),
        ],
      ],
    );
  }

  Widget _buildTimeUnit({
    required String label,
    required String value,
    required TextStyle numberStyle,
    required TextStyle labelStyle,
    required double labelSpacing,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: labelStyle,
        ),
        SizedBox(height: labelSpacing),
        Text(
          value,
          style: numberStyle,
        ),
      ],
    );
  }
}
