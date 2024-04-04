import 'package:bloc/bloc.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(SettingsState initialState) : super(initialState);

double threshold = 120.0;

  void init() {
    add(SettingsInitEvent(threshold));
  }


  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsInitEvent) {
      yield SettingsInitiated(event.threshold);
    } else if (event is ThresholdChangeEvent) {
      threshold = event.threshold;
      yield SettingsChanged(event.threshold);
    }
  }
}
