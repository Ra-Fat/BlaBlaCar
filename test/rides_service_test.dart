import 'package:blabcar/models/ride/locations.dart';

import '../lib/services/rides_service.dart';

void main() {
  RidesService.filterBy(
    departure: Location(name: "Dijon", country: Country.france),
    seatRequested: 2,
  );
}
