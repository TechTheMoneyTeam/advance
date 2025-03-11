import 'package:week_3_blabla_project/model/ride/locations.dart';
import '../model/ride_pref/ride_pref.dart';

abstract class RidePreferencesListener {
  void onPreferenceSelected(RidePref selectedPreference);
}

class RidePreferencesService {
  final List<RidePreferencesListener> _listeners = [];
  RidePref? _currentPreference;

  void addListener(RidePreferencesListener listener) {
    _listeners.add(listener);
  }

  void notifyListeners() {
    if (_currentPreference == null) return;
    for (var listener in _listeners) {
      listener.onPreferenceSelected(_currentPreference!);
    }
  }

  void setCurrentPreference(RidePref preference) {
    _currentPreference = preference;
    notifyListeners();
  }
}

class ConsoleLogger implements RidePreferencesListener {
  @override
  void onPreferenceSelected(RidePref selectedPreference) {
    print('Console Logger: Ride preference selected: $selectedPreference');
  }
}

void main() {
  RidePreferencesService riderservice = RidePreferencesService();
  riderservice.addListener(ConsoleLogger());
      riderservice.setCurrentPreference(RidePref(
      departure: Location(name: 'Siem Reap', country: Country.cambodia),
      arrival: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime.now(),
      requestedSeats: 1));
}
