// screens/rides/widgets/ride_tile.dart
import 'package:flutter/material.dart';
import '../../../../model/ride/ride.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/date_time_util.dart';

class RideTile extends StatelessWidget {
  final Ride ride;
  final VoidCallback? onTap;
  
  const RideTile({
    Key? key,
    required this.ride,
    this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(BlaSpacings.m),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: BlaColors.borderLight,
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Times and price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Departure time
                Text(
                  DateTimeUtils.formatTime(ride.departureDate),
                  style: BlaTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // Price
                Text(
                  '€${ride.pricePerSeat.toStringAsFixed(2)}',
                  style: BlaTextStyles.heading.copyWith(
                    color: BlaColors.primary,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: BlaSpacings.s),
            
            // Departure location
            Row(
              children: [
                Icon(
                  Icons.circle_outlined,
                  size: 16,
                  color: BlaColors.primary,
                ),
                SizedBox(width: BlaSpacings.s),
                Expanded(
                  child: Text(
                    ride.departureLocation.name,
                    style: BlaTextStyles.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            
            // Connector line
            Padding(
              padding: EdgeInsets.only(
                left: 7.5, // Half of the icon size (16/2) - half of the line width (1/2)
              ),
              child: Container(
                width: 1,
                height: 16,
                color: BlaColors.borderNormal,
              ),
            ),
            
            // Arrival location and time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Arrival location
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: BlaColors.primary,
                      ),
                      SizedBox(width: BlaSpacings.s),
                      Expanded(
                        child: Text(
                          ride.arrivalLocation.name,
                          style: BlaTextStyles.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Arrival time
                Text(
                  DateTimeUtils.formatTime(ride.arrivalDateTime),
                  style: BlaTextStyles.bodyMedium,
                ),
              ],
            ),
            
            SizedBox(height: BlaSpacings.m),
            
            // Driver info and seats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Driver info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(ride.driver.profilePicture),
                    ),
                    SizedBox(width: BlaSpacings.s),
                    Text(
                      ride.driver.firstName,
                      style: BlaTextStyles.bodyMedium,
                    ),
                    if (ride.driver.verifiedProfile)
                      Padding(
                        padding: EdgeInsets.only(left: BlaSpacings.s),
                        child: Icon(
                          Icons.verified_user,
                          size: 16,
                          color: BlaColors.primary,
                        ),
                      ),
                  ],
                ),
                
                // Available seats
                Row(
                  children: [
                    Icon(
                      Icons.airline_seat_recline_normal,
                      size: 16,
                      color: BlaColors.secondaryText,
                    ),
                    SizedBox(width: BlaSpacings.s),
                    Text(
                      '${ride.remainingSeats} ${ride.remainingSeats > 1 ? "seats" : "seat"} left',
                      style: BlaTextStyles.body.copyWith(
                        color: BlaColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}