import 'package:equatable/equatable.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent(this.threshold);

  @override
  List<Object> get props => [threshold];

  final double threshold;
}

class SettingsInitEvent extends SettingsEvent {
  const SettingsInitEvent(super.threshold);
}

class ThresholdChangeEvent extends SettingsEvent {
  const ThresholdChangeEvent(super.threshold);
}