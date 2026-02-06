import '../data/dummy_data.dart';
import '../models/ride/ride.dart';
import '../models/ride/locations.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  //
  //  filter the rides starting from given departure location
  //
  static List<Ride> _filterByDeparture(Location departure) {
    return availableRides.where((ride) => ride.departureLocation == departure).toList();
  }

  //
  //  filter the rides starting for the given requested seat number
  //
  static List<Ride> _filterBySeatRequested(int requestedSeat) {
    return availableRides.where((ride) => ride.availableSeats >= requestedSeat).toList();
  }

  //
  //  filter the rides   with several optional criteria (flexible filter options)
  //
  static List<Ride> filterBy({Location? departure, int? seatRequested}) {

    if (departure != null) {
      availableRides = availableRides.where((ride) => ride.departureLocation == departure).toList();
    }

    if(seatRequested !=null){
      availableRides = availableRides.where((ride) => ride.remainingSeats >= seatRequested).toList();
    }

    return availableRides;
  }
}
