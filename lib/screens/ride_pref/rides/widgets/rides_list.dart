// screens/rides/widgets/rides_list.dart
import 'package:flutter/material.dart';
import '../../../../model/ride/ride.dart';
import '../../../../theme/theme.dart';
import 'ride_tile.dart';

class RidesList extends StatelessWidget {
  final List<Ride> rides;
  
  const RidesList({
    Key? key,
    required this.rides,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        return RideTile(
          ride: ride,
          onTap: () {
            // For now, just show a snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected ride from ${ride.departureLocation.name} to ${ride.arrivalLocation.name}'),
              ),
            );
          },
        );
      },
    );
  }
}