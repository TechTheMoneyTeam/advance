// screens/rides/widgets/ride_pref_summary.dart
import 'package:flutter/material.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/date_time_util.dart';

class RidePrefSummary extends StatelessWidget {
  final RidePref preference;
  final VoidCallback? onEdit;
  
  const RidePrefSummary({
    Key? key,
    required this.preference,
    this.onEdit,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          // Route information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // From-To information
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
                        preference.departure.name,
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
                    height: 8,
                    color: BlaColors.borderNormal,
                  ),
                ),
                
                // Destination
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: BlaColors.primary,
                    ),
                    SizedBox(width: BlaSpacings.s),
                    Expanded(
                      child: Text(
                        preference.arrival.name,
                        style: BlaTextStyles.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: BlaSpacings.s),
                
                // Date and seats
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: BlaColors.secondaryText,
                    ),
                    SizedBox(width: BlaSpacings.s),
                    Text(
                      DateTimeUtils.formatDateTime(preference.departureDate),
                      style: BlaTextStyles.body.copyWith(
                        color: BlaColors.secondaryText,
                      ),
                    ),
                    SizedBox(width: BlaSpacings.m),
                    Icon(
                      Icons.person_outline,
                      size: 16,
                      color: BlaColors.secondaryText,
                    ),
                    SizedBox(width: BlaSpacings.s),
                    Text(
                      '${preference.requestedSeats} ${preference.requestedSeats > 1 ? "passengers" : "passenger"}',
                      style: BlaTextStyles.body.copyWith(
                        color: BlaColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Edit button
          if (onEdit != null)
            IconButton(
              icon: Icon(
                Icons.edit_outlined,
                color: BlaColors.primary,
              ),
              onPressed: onEdit,
            ),
        ],
      ),
    );
  }
}