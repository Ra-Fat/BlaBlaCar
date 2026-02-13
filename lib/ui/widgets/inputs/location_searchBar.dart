import 'package:flutter/material.dart';
import '../../theme/theme.dart';


class LocationSearchBar extends StatefulWidget {
  const LocationSearchBar({
    super.key,
    required this.onBackTap,
    required this.onSearchChanged,
    required this.initSearch,
  });

  final String initSearch;
  final VoidCallback onBackTap;
  final ValueChanged<String> onSearchChanged;

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void onClearTap() {
    _searchController.clear();
  }

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initSearch;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool get searchIsNotEmpty => _searchController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BlaColors.greyLight,
      ),
      child: Row(
        children: [
          // BACK ICON
          IconButton(
            onPressed: widget.onBackTap,
            icon: Icon(
              Icons.arrow_back_ios,
              color: BlaColors.iconLight,
              size: 16,
            ),
          ),

          // TEXT FILED
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: widget.onSearchChanged,
              style: TextStyle(color: BlaColors.textLight),
              decoration: InputDecoration(
                hintText: "Search Any location",
                border: InputBorder.none,
                filled: false,
              ),
            ),
          ),

          // CLOSE ICON
          searchIsNotEmpty
              ? IconButton(
                  onPressed: onClearTap,
                  icon: Icon(Icons.close, color: BlaColors.iconLight, size: 16),
                )
              : SizedBox.shrink(), // Hides the icon if text field is empty
        ],
      ),
    );
  }
}
