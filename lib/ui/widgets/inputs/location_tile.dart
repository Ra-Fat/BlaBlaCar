import 'package:flutter/material.dart';
import '../../../models/ride/locations.dart';
import '../../widgets/display/bla_divider.dart';
import '../../theme/theme.dart';

/// A reusable widget for displaying a location in the list
class LocationTile extends StatelessWidget {
  const LocationTile({super.key, required this.location, required this.onTap});

  final Location location;

  final ValueChanged<Location> onTap;

  String get title => location.name;

  String get subTitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(location),
          leading: Icon(Icons.history, color: BlaColors.iconLight),

          title: Text(title, style: BlaTextStyles.body),
          subtitle: Text(
            subTitle,
            style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
          ),

          trailing: Icon(
            Icons.arrow_forward_ios,
            color: BlaColors.iconLight,
            size: 16,
          ),
        ),
        BlaDivider(),
      ],
    );
  }
}
