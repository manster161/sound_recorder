import 'package:equatable/equatable.dart';

sealed class SettingsState extends Equatable {
  const SettingsState(this.thresholdLevel);

  @override
  List<Object> get props => [thresholdLevel];   
  final double thresholdLevel;
}

class SettingsInitiated extends SettingsState {
  const SettingsInitiated(super.thresholdLevel);
}

class SettingsChanged extends SettingsState {
  const SettingsChanged(super.thresholdLevel);
}