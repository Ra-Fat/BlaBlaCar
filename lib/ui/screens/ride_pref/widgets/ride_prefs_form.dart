import 'package:flutter/material.dart';

import '../../../../models/ride/locations.dart';
import '../../../../models/ride_pref/ride_pref.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../../services/location_service.dart';
import '../../../theme/theme.dart';
import '../../../../utils/date_time_utils.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/inputs/location_picker.dart';
import 'form_picker.dart';

///
/// A Ride Preference From is a view to select:
///   - A departure location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  bool swapOnDeparture = true;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();

    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      // If no given preferences, we select default ones :
      departure = null; // User shall select the departure
      departureDate = DateTime.now(); // Now  by default
      arrival = null; // User shall select the arrival
      requestedSeats = 1; // 1 seat book by default
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // Open a screen to pick the departure location
  void _onDeparturePressed() async {
    final Location? selectedLocation = await Navigator.push<Location>(
      context,
      MaterialPageRoute(
        builder: (_) => LocationPicker(
          location: departure,
        ),
      ),
    );
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  // Open a date picker to select the departure date
  void _onArrivalPressed() async {
    final Location? selectedLocation = await Navigator.push<Location>(
      context,
      MaterialPageRoute(
        builder: (_) => LocationPicker(
          location: arrival,
        ),
      ),
    );
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  // just a mock test
  void _onDatePressed() async {
    
  }

  void _onSeatsPressed() {
    // TODO: Show seats picker
  }


  /// Swap the departure and arrival locations
  void _onSwapLocation() {
    if (departure != null || arrival != null) {
      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;
      });
    }
  }


  void _onSubmit() async{
    // Check that departure and arrival are selected
    if (departure == null || arrival == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both departure and arrival locations'),
        ),
      );
      return;
    }

    // Check if departure and arrival are the same
    if (departure == arrival) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Departure and arrival cannot be the same'),
        ),
      );
      return;
    }

    // Will implement the check specific data and number of user later on

    final ridePref = RidePref(
      departure: departure!,
      arrival: arrival!,
      departureDate: departureDate,
      requestedSeats: requestedSeats,
    );

    Navigator.pop(context, ridePref);
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get date => DateTimeUtils.formatDateTime(departureDate);
  
  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          
          // Departure Location
          FormPicker(
            isPlaceHolder: showDeparturePLaceHolder,
            title: departureLabel,
            leftIcon: Icons.location_on,
            onTab: _onDeparturePressed,
            rightIcon: switchVisible ? Icons.swap_vert : null,
            onRightIconTab: switchVisible
                ? _onSwapLocation
                : null,
          ),

          BlaDivider(),

          // Arrival Location
          FormPicker(
            isPlaceHolder: showArrivalPLaceHolder,
            title: arrivalLabel,
            leftIcon: Icons.location_on,
            onTab: _onArrivalPressed,
          ),

          BlaDivider(),

          // Date Picker
          // just a mock test
          FormPicker(
            title: dateLabel,
            leftIcon: Icons.calendar_month,
            onTab: _onDatePressed,
          ),

          BlaDivider(),

          // Seat Picker
          // not implemented for now
          FormPicker(
            title: numberLabel,
            leftIcon: Icons.person_2_outlined,
            onTab: () => {},
          ),

          const SizedBox(height: BlaSpacings.s),

          // Search Button
          // not implemented yet
          BlaButton(text: 'Search', isPrimary: true, onTab: _onSubmit),
        ],
      ),
    );
  }
}
