// screens/location_picker/location_picker_screen.dart
import 'package:flutter/material.dart';
import '../../model/ride/locations.dart';
import '../../service/locations_service.dart';
import '../../theme/theme.dart';
import '../../widgets/display/bla_background.dart';
import '../../widgets/inputs/blasearchfield.dart';
import 'widgets/location_tile.dart';

class LocationPickerScreen extends StatefulWidget {
  final String title;
  final Location? excludeLocation;
  
  const LocationPickerScreen({
    Key? key,
    required this.title,
    this.excludeLocation,
  }) : super(key: key);

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late List<Location> _locations;
  late List<Location> _filteredLocations;
  String _searchQuery = '';
  
  @override
  void initState() {
    super.initState();
    // Get all locations from service
    _locations = LocationsService.getLocations();
    _filteredLocations = List.from(_locations);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: BlaColors.primary,
     
        elevation: 0,
      ),
      body: BlaBackground(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: EdgeInsets.all(BlaSpacings.m),
              child: BlaSearchField(
                hint: 'Search locations',
                onChanged: _filterLocations,
                onClear: _resetFilter,
              ),
            ),
            
            // Location list
            Expanded(
              child: _filteredLocations.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      itemCount: _filteredLocations.length,
                      itemBuilder: (context, index) {
                        final location = _filteredLocations[index];
                        final isDisabled = widget.excludeLocation != null && 
                                         location == widget.excludeLocation;
                        
                        return LocationTile(
                          location: location,
                          isDisabled: isDisabled,
                          onTap: isDisabled ? null : () => _selectLocation(location),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: BlaColors.secondaryText,
          ),
          SizedBox(height: BlaSpacings.m),
          Text(
            'No locations found',
            style: BlaTextStyles.heading.copyWith(
              color: BlaColors.secondaryText,
            ),
          ),
          SizedBox(height: BlaSpacings.s),
          Text(
            'Try a different search term',
            style: BlaTextStyles.bodyMedium.copyWith(
              color: BlaColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
  
  void _filterLocations(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredLocations = _locations.where((location) {
        return location.name.toLowerCase().contains(_searchQuery);
      }).toList();
    });
  }
  
  void _resetFilter() {
    setState(() {
      _searchQuery = '';
      _filteredLocations = List.from(_locations);
    });
  }
  
  void _selectLocation(Location location) {
    Navigator.of(context).pop(location);
  }
}