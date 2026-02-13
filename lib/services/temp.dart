class WeatherStation {
  int _temperature = 0;

  int get temperature => _temperature;

  final List<WeatherStationListener> _listeners = [];

  void addListener(WeatherStationListener listener) {
    _listeners.add(listener);
  }

  void setTemperature(int newTemperature) {
    if (newTemperature != _temperature) {
      _temperature = newTemperature;
      _notifyListener();
    }
  }

  void _notifyListener() {
    for (WeatherStationListener l in _listeners) {
      l.onTemperatureChanged(_temperature);
    }
  }
}


abstract class WeatherStationListener {
  void onTemperatureChanged(int newTemperature);
}

class WebWeatherApp extends WeatherStationListener {
  @override
  void onTemperatureChanged(int newTemperature) {
    print("<h1> The is the new temperature ${newTemperature.toString()}<h1>");
  }
}

class MobileApp extends WeatherStationListener {
  @override
  void onTemperatureChanged(int newTemperature) {
    print(
      "scafold. text =  The is the new temperature ${newTemperature.toString()}",
    );
  }
}

void main() {
  WeatherStation myStation = WeatherStation();

  WebWeatherApp webApp = WebWeatherApp();
  MobileApp mobileApp = MobileApp();
  myStation.addListener(webApp);
  myStation.addListener(mobileApp);

  myStation.setTemperature(40);
}
