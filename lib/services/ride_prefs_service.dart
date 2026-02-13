import '../data/dummy_data.dart';
import '../models/ride_pref/ride_pref.dart';

////
///   This service handles:
///   - History of the last ride preferences        (to allow users to re-use their last preferences)
///   - Curent selected ride preferences.
///
class RidePrefService {
  ///
  /// List of past entered ride prefs. LIFO (most recents first)
  ///
  static List<RidePref> ridePrefsHistory = fakeRidePrefs;
  static RidePref? currentRidePref;
  final List<RidePrefListener> _listeners = [];

  static bool get hasCurrentRidePref => currentRidePref != null;

  void addListener(RidePrefListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  // set select pref
  void selectPreference(RidePref preference) {
    if (currentRidePref != preference) {
      currentRidePref = preference;
      _notifyListeners(preference);
    }
  }


  void _notifyListeners(RidePref selectedPrev) {
    for (RidePrefListener l in _listeners) {
      l.onPrevSelected(selectedPrev);
    }
  }
}

abstract class RidePrefListener {
  void onPrevSelected(RidePref selectedPrev);
}

class ConsoleLogger implements RidePrefListener {
  @override
  void onPrevSelected(RidePref selectedPreference) {
    print('Preference changed: $selectedPreference');
  }
}


void main() {
  RidePrefService myService = RidePrefService();

  ConsoleLogger consoleLogger = ConsoleLogger();
  myService.addListener(consoleLogger);

  if (RidePrefService.ridePrefsHistory.isNotEmpty) {
    myService.selectPreference(RidePrefService.ridePrefsHistory.first);
  }
}
