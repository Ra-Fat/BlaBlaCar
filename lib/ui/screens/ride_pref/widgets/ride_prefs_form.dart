import 'package:flutter/material.dart';

import '../../../../models/ride/locations.dart';
import '../../../../models/ride_pref/ride_pref.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../../services/location_service.dart';
import '../../../theme/theme.dart';
import '../../../../utils/date_time_utils.dart';
import '../../../widgets/display/bla_divider.dart';
import 'location_picker.dart';
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
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // Open a screen to pick the departure location
  void _onDeparturePressed() async {
    final Location? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationPicker(
          locations: LocationsService.availableLocations,
          selected: departure,
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
    final Location? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationPicker(
          locations: LocationsService.availableLocations,
          selected: arrival,
        ),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  // Open a pop up date picker
  // just a mock test
  void _onDatePressed() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime(2026),
      lastDate: DateTime(2027),
    );

    if (pickedDate != null) {
      setState(() {
        departureDate = pickedDate;
      });
    }
  }

  void _onSeatsPressed() {
    // TODO: Show seats picker
  }

  // /// Check if a given date is today
  // bool _isToday(DateTime date) {
  //   final now = DateTime.now();
  //   return date.year == now.year &&
  //       date.month == now.month &&
  //       date.day == now.day;
  // }

  /// Swap the departure and arrival locations
  void _onSwapLocation() {
    if (departure != null || arrival != null) {
      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;

        // move swap icon to other picker
        swapOnDeparture = !swapOnDeparture;
      });
    }
  }


  void _onSearchPressed() async{
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
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get date => DateTimeUtils.formatDateTime(departureDate);

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
          formPicker(
            icon: Icons.circle_outlined,
            label: 'Leaving from',
            value: departure?.name,
            onTap: _onDeparturePressed,
            showSwapIcon:
                swapOnDeparture && (departure != null || arrival != null),
            onSwap: _onSwapLocation,
          ),

          BlaDivider(),

          // Arrival Location
          formPicker(
            icon: Icons.circle_outlined,
            label: 'Going to',
            value: arrival?.name,
            onTap: _onArrivalPressed,
            showSwapIcon:
                !swapOnDeparture && (departure != null || arrival != null),
            onSwap: _onSwapLocation,
          ),

          BlaDivider(),

          // Date Picker
          // just a mock test
          formPicker(
            icon: Icons.calendar_month,
            label: date,
            value: null,
            onTap: _onDatePressed,
          ),

          BlaDivider(),

          // Seat Picker
          // not implemented for now
          formPicker(
            icon: Icons.person_outline,
            label: requestedSeats.toString(),
            value: null,
            onTap: _onSeatsPressed,
          ),

          const SizedBox(height: BlaSpacings.s),

          // Search Button
          // not implemented yet
          BlaButton(text: 'Search', isPrimary: true, onTab: _onSearchPressed),
        ],
      ),
    );
  }
}
