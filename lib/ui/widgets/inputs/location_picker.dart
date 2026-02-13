import 'package:flutter/material.dart';
import '../../../models/ride/locations.dart';
import '../../../services/location_service.dart';
import '../../theme/theme.dart';
import './location_searchBar.dart';
import 'location_tile.dart';

/// Screen that allows user to search and select a location
class LocationPicker extends StatefulWidget {
  final Location? location;

  const LocationPicker({super.key, required this.location});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  // Stores locations after filtering by search text
  late List<Location> filteredLocations;

  // Used to stores current search input
  String CurrentSearch = '';

  void onTap(Location location) {
    Navigator.pop<Location>(context, location);
  }

  void onBackTap() {
    Navigator.pop<Location>(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.location != null) {
      setState(() {
        CurrentSearch = widget.location!.name;
      });
    }
  }

  void onSearchChanged(String search) {
    setState(() {
      CurrentSearch = search;
    });
  }


  List<Location> get filteredLocation {
    if (CurrentSearch.length < 2) {
      return [];
    }
    return LocationsService.availableLocations
        .where(
          (location) => location.name.toUpperCase().contains(
            CurrentSearch.toUpperCase(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(BlaSpacings.m),
        child: Column(
          children: [
            LocationSearchBar(
              initSearch: CurrentSearch,
              onBackTap: onBackTap,
              onSearchChanged: onSearchChanged,
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: filteredLocation.length,
                itemBuilder: (context, index) => LocationTile(
                  location: filteredLocation[index],
                  onTap: onTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
