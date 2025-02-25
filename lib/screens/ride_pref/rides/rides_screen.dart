import 'package:flutter/material.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../../theme/theme.dart';
import '../../../widgets/display/bla_background.dart';
import 'widgets/ride_pref_summary.dart';
import 'widgets/rides_list.dart';

class RidesScreen extends StatefulWidget {
  final RidePref preference;
  
  const RidesScreen({
    Key? key,
    required this.preference,
  }) : super(key: key);
  
  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late List<Ride> _rides;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadRides();
  }
  
  Future<void> _loadRides() async {
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _rides = RidesService.getRidesByPreference(widget.preference);
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rides'),
        backgroundColor: BlaColors.primary,
        
        elevation: 0,
      ),
      body: BlaBackground(
        child: Column(
          children: [
            // Ride preference summary
            RidePrefSummary(
              preference: widget.preference,
              onEdit: () => Navigator.of(context).pop(),
            ),
            
            // Results count or loading indicator
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: BlaSpacings.m,
                vertical: BlaSpacings.s,
              ),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(BlaColors.primary),
                      ),
                    )
                  : Text(
                      '${_rides.length} rides found',
                      style: BlaTextStyles.bodyMedium.copyWith(
                        color: BlaColors.secondaryText,
                      ),
                    ),
            ),
            
            // Rides list
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(BlaColors.primary),
                      ),
                    )
                  : _rides.isEmpty
                      ? _buildEmptyState()
                      : RidesList(rides: _rides),
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
            'No rides found',
            style: BlaTextStyles.body.copyWith(
              color: BlaColors.secondaryText,
            ),
          ),
          SizedBox(height: BlaSpacings.s),
          Text(
            'Try different search criteria',
            style: BlaTextStyles.bodyMedium.copyWith(
              color: BlaColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}