import 'package:flutter/material.dart';
import '../../../../models/ride/locations.dart';
import '../../../theme/theme.dart';

/// Screen that allows user to search and select a location
class LocationPicker extends StatefulWidget {
  
  // List of all available locations
  final List<Location> locations;
  final Location? selected;

  const LocationPicker({super.key, required this.locations, this.selected});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  
  // Stores locations after filtering by search text
  late List<Location> filteredLocations;
  
  // Used to stores current search input
  String search = '';

  @override
  void initState() {
    super.initState();
    filteredLocations = widget.locations;
  }

  // Called every time user types in search box
  void _onSearchChanged(String locationSearched) {
    setState(() {
      search = locationSearched;
      filteredLocations = widget.locations
          .where(
            (l) =>
                l.name.toLowerCase().contains(locationSearched.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: BlaColors.greyLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: BlaSpacings.s),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search location...',
                    border: InputBorder.none,
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
            ],
          ),
        ),
      ),
      
      // List of filtered locations
      body: ListView.builder(
        itemCount: filteredLocations.length,
        itemBuilder: (context, index) {
          final location = filteredLocations[index];
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: BlaColors.greyLight, width: 1),
              ),
            ),
            child: ListTile(
              title: Text(location.name),
              subtitle: Text(
                location.country.name,
                style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: BlaColors.iconLight,
                size: 16,
              ),
              onTap: () {
                Navigator.pop(context, location);
              },
            ),
          );
        },
      ),
    );
  }
}
